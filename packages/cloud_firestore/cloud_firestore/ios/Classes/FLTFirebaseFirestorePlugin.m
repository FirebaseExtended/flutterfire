// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Firebase/Firebase.h>
#import <firebase_core/FLTFirebasePluginRegistry.h>

#import <TargetConditionals.h>
#import "Private/FLTDocumentSnapshotStreamHandler.h"
#import "Private/FLTFirebaseFirestoreUtils.h"
#import "Private/FLTLoadBundleStreamHandler.h"
#import "Private/FLTQuerySnapshotStreamHandler.h"
#import "Private/FLTSnapshotsInSyncStreamHandler.h"
#import "Private/FLTTransactionStreamHandler.h"
#import "Private/PigeonParser.h"
#import "Public/FLTFirebaseFirestorePlugin.h"

NSString *const kFLTFirebaseFirestoreChannelName = @"plugins.flutter.io/firebase_firestore";
NSString *const kFLTFirebaseFirestoreQuerySnapshotEventChannelName =
    @"plugins.flutter.io/firebase_firestore/query";
NSString *const kFLTFirebaseFirestoreDocumentSnapshotEventChannelName =
    @"plugins.flutter.io/firebase_firestore/document";
NSString *const kFLTFirebaseFirestoreSnapshotsInSyncEventChannelName =
    @"plugins.flutter.io/firebase_firestore/snapshotsInSync";
NSString *const kFLTFirebaseFirestoreTransactionChannelName =
    @"plugins.flutter.io/firebase_firestore/transaction";
NSString *const kFLTFirebaseFirestoreLoadBundleChannelName =
    @"plugins.flutter.io/firebase_firestore/loadBundle";

@interface FLTFirebaseFirestorePlugin ()
@property(nonatomic, retain) NSMutableDictionary *transactions;

/// Registers a unique event channel based on a channel prefix.
///
/// Once registered, the plugin will take care of removing the stream handler and cleaning up,
/// if the engine is detached.
///
/// This function generates a random ID.
///
/// @param prefix Channel prefix onto which the unique ID will be appended on. The convention is
///     "namespace/component" whereas the last / is added internally.
/// @param handler The handler object for responding to channel events and submitting data.
/// @return The generated identifier.
/// @see #registerEventChannel(String, String, StreamHandler)
- (NSString *)registerEventChannelWithPrefix:(NSString *)prefix
                               streamHandler:(NSObject<FlutterStreamHandler> *)handler;

/// Registers a unique event channel based on a channel prefix.
///
/// Once registered, the plugin will take care of removing the stream handler and cleaning up,
/// if the engine is detached.
///
/// @param prefix Channel prefix onto which the unique ID will be appended on. The convention is
/// "namespace/component" whereas the last / is added internally.
/// @param identifier A identifier which will be appended to the prefix.
/// @param handler The handler object for responding to channel events and submitting data.
/// @return The passed identifier.
/// @see #registerEventChannel(String, String, StreamHandler)
- (NSString *)registerEventChannelWithPrefix:(NSString *)prefix
                                  identifier:(NSString *)identifier
                               streamHandler:(NSObject<FlutterStreamHandler> *)handler;
@end

static NSCache<NSNumber *, NSString *> *_serverTimestampMap;

@implementation FLTFirebaseFirestorePlugin {
  NSMutableDictionary<NSString *, FlutterEventChannel *> *_eventChannels;
  NSMutableDictionary<NSString *, NSObject<FlutterStreamHandler> *> *_streamHandlers;
  NSMutableDictionary<NSString *, FLTTransactionStreamHandler *> *_transactionHandlers;
  NSObject<FlutterBinaryMessenger> *_binaryMessenger;
}

FlutterStandardMethodCodec *_codec;

+ (NSMutableDictionary<NSNumber *, NSString *> *)serverTimestampMap {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _serverTimestampMap = [NSCache<NSNumber *, NSString *> new];
  });
  return _serverTimestampMap;
}

+ (void)initialize {
  _codec =
      [FlutterStandardMethodCodec codecWithReaderWriter:[FLTFirebaseFirestoreReaderWriter new]];
}

#pragma mark - FlutterPlugin

// Returns a singleton instance of the Firebase Firestore plugin.
//+ (instancetype)sharedInstance {
//  static dispatch_once_t onceToken;
//  static FLTFirebaseFirestorePlugin *instance;
//
//  dispatch_once(&onceToken, ^{
//    instance = [[FLTFirebaseFirestorePlugin alloc] init];
//    // Register with the Flutter Firebase plugin registry.
//    [[FLTFirebasePluginRegistry sharedInstance] registerFirebasePlugin:instance];
//  });
//
//  return instance;
//}

- (instancetype)init:(NSObject<FlutterBinaryMessenger> *)messenger {
  self = [super init];
  if (self) {
    _binaryMessenger = messenger;
    _transactions = [NSMutableDictionary<NSNumber *, FIRTransaction *> dictionary];
    _eventChannels = [NSMutableDictionary dictionary];
    _streamHandlers = [NSMutableDictionary dictionary];
    _transactionHandlers = [NSMutableDictionary dictionary];
  }
  return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:kFLTFirebaseFirestoreChannelName
                                  binaryMessenger:[registrar messenger]
                                            codec:_codec];

  FLTFirebaseFirestorePlugin *instance =
      [[FLTFirebaseFirestorePlugin alloc] init:[registrar messenger]];
  [registrar addMethodCallDelegate:instance channel:channel];

#if TARGET_OS_OSX
// TODO(Salakar): Publish does not exist on MacOS version of FlutterPluginRegistrar.
#else
  [registrar publish:instance];
#endif
}

- (void)cleanupEventListeners {
  for (FlutterEventChannel *channel in self->_eventChannels) {
    [channel setStreamHandler:nil];
  }
  [self->_eventChannels removeAllObjects];
  for (NSObject<FlutterStreamHandler> *handler in self->_streamHandlers) {
    [handler onCancelWithArguments:nil];
  }
  [self->_streamHandlers removeAllObjects];

  @synchronized(self->_transactions) {
    [self->_transactions removeAllObjects];
  }
}

- (void)cleanupFirestoreInstances:(void (^)(void))completion {
  if ([FLTFirebaseFirestoreUtils count] > 0) {
    [FLTFirebaseFirestoreUtils cleanupFirestoreInstances:completion];
  } else {
    if (completion != nil) completion();
  }
}

- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  [self cleanupEventListeners];
}

#pragma mark - FLTFirebasePlugin

- (void)didReinitializeFirebaseCore:(void (^)(void))completion {
  [self cleanupEventListeners];
  [self cleanupFirestoreInstances:completion];
}

- (NSDictionary *_Nonnull)pluginConstantsForFIRApp:(FIRApp *)firebase_app {
  return @{};
}

- (NSString *_Nonnull)firebaseLibraryName {
  return LIBRARY_NAME;
}

- (NSString *_Nonnull)firebaseLibraryVersion {
  return LIBRARY_VERSION;
}

- (NSString *_Nonnull)flutterChannelName {
  return kFLTFirebaseFirestoreChannelName;
}

#pragma mark - Firestore API

- (NSString *)registerEventChannelWithPrefix:(NSString *)prefix
                               streamHandler:(NSObject<FlutterStreamHandler> *)handler {
  return [self registerEventChannelWithPrefix:prefix
                                   identifier:[[[NSUUID UUID] UUIDString] lowercaseString]
                                streamHandler:handler];
}

- (NSString *)registerEventChannelWithPrefix:(NSString *)prefix
                                  identifier:(NSString *)identifier
                               streamHandler:(NSObject<FlutterStreamHandler> *)handler {
  NSString *channelName = [NSString stringWithFormat:@"%@/%@", prefix, identifier];

  FlutterEventChannel *channel = [[FlutterEventChannel alloc] initWithName:channelName
                                                           binaryMessenger:_binaryMessenger
                                                                     codec:_codec];

  [channel setStreamHandler:handler];
  [_eventChannels setObject:channel forKey:identifier];
  [_streamHandlers setObject:handler forKey:identifier];

  return identifier;
}

- (FIRFirestore *_Nullable)getFIRFirestoreFromAppNameFromPigeon:(PigeonFirebaseApp *)pigeonApp {
  FIRApp *app = [FLTFirebasePlugin firebaseAppNamed:pigeonApp.appName];
  FIRFirestore *firestore = [FIRFirestore firestoreForApp:app];

  return firestore;
}

- (FlutterError *)convertToFlutterError:(NSError *)error {
  NSString *code = [NSString stringWithFormat:@"ios-%ld", (long)error.code];
  NSString *message = @"An unknown error has occurred.";

  if (error == nil) {
    return [FlutterError errorWithCode:code message:message details:@{}];
  }

  // message
  if ([error userInfo][NSLocalizedDescriptionKey] != nil) {
    message = [error userInfo][NSLocalizedDescriptionKey];
  }

  NSMutableDictionary *additionalData = [NSMutableDictionary dictionary];

  return [FlutterError errorWithCode:code message:message details:additionalData];
}

- (void)aggregateQueryCountApp:(nonnull PigeonFirebaseApp *)app
                          path:(nonnull NSString *)path
                    parameters:(nonnull PigeonQueryParameters *)parameters
                        source:(AggregateSource)source
                    completion:
                        (nonnull void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];

  FIRQuery *query = [PigeonParser parseQueryWithParameters:parameters
                                                 firestore:firestore
                                                      path:path
                                         isCollectionGroup:NO];

  FIRAggregateQuery *aggregateQuery = [query count];

  [aggregateQuery aggregationWithSource:FIRAggregateSourceServer
                             completion:^(FIRAggregateQuerySnapshot *_Nullable snapshot,
                                          NSError *_Nullable error) {
                               if (error != nil) {
                                 completion(nil, [self convertToFlutterError:error]);
                               } else {
                                 completion(snapshot.count, nil);
                               }
                             }];
}

- (void)clearPersistenceApp:(nonnull PigeonFirebaseApp *)app
                 completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  [firestore clearPersistenceWithCompletion:^(NSError *error) {
    if (error != nil) {
      completion([self convertToFlutterError:error]);
    } else {
      completion(nil);
    }
  }];
}

- (void)disableNetworkApp:(nonnull PigeonFirebaseApp *)app
               completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  [firestore disableNetworkWithCompletion:^(NSError *error) {
    if (error != nil) {
      completion([self convertToFlutterError:error]);
    } else {
      completion(nil);
    }
  }];
}

- (void)documentReferenceDeleteApp:(nonnull PigeonFirebaseApp *)app
                           request:(nonnull DocumentReferenceRequest *)request
                        completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRDocumentReference *document = [firestore documentWithPath:request.path];

  [document deleteDocumentWithCompletion:^(NSError *error) {
    if (error != nil) {
      completion([self convertToFlutterError:error]);
    } else {
      completion(nil);
    }
  }];
}

- (void)terminate:(id)arguments withMethodCallResult:(FLTFirebaseMethodCallResult *)result {
  FIRFirestore *firestore = arguments[@"firestore"];
  [firestore terminateWithCompletion:^(NSError *error) {
    if (error != nil) {
      result.error(nil, nil, nil, error);
    } else {
      FLTFirebaseFirestoreExtension *firestoreExtension =
          [FLTFirebaseFirestoreUtils getCachedInstanceForFirestore:firestore];
      [FLTFirebaseFirestoreUtils destroyCachedInstanceForFirestore:firestore.app.name
                                                       databaseURL:firestoreExtension.databaseURL];
      result.success(nil);
    }
  }];
}

- (void)documentReferenceGetApp:(nonnull PigeonFirebaseApp *)app
                        request:(nonnull DocumentReferenceRequest *)request
                     completion:(nonnull void (^)(PigeonDocumentSnapshot *_Nullable,
                                                  FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRDocumentReference *document = [firestore documentWithPath:request.path];
  FIRFirestoreSource source = [PigeonParser parseSource:request.source];
  FIRServerTimestampBehavior serverTimestampBehavior =
      [PigeonParser parseServerTimestampBehavior:request.serverTimestampBehavior];

  id completionGet = ^(FIRDocumentSnapshot *_Nullable snapshot, NSError *_Nullable error) {
    if (error != nil) {
      completion(nil, [self convertToFlutterError:error]);
    } else {
      completion([PigeonParser toPigeonDocumentSnapshot:snapshot
                                serverTimestampBehavior:serverTimestampBehavior],
                 nil);
    }
  };

  [document getDocumentWithSource:source completion:completionGet];
}

- (void)documentReferenceSetApp:(nonnull PigeonFirebaseApp *)app
                        request:(nonnull DocumentReferenceRequest *)request
                     completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  id data = request.data;
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRDocumentReference *document = [firestore documentWithPath:request.path];

  void (^completionBlock)(NSError *) = ^(NSError *error) {
    if (error != nil) {
      completion([self convertToFlutterError:error]);
    } else {
      completion(nil);
    }
  };

  if ([request.option.merge isEqual:@YES]) {
    [document setData:data merge:YES completion:completionBlock];
  } else if (![request.option.mergeFields isEqual:[NSNull null]]) {
    [document setData:data mergeFields:request.option.mergeFields completion:completionBlock];
  } else {
    [document setData:data completion:completionBlock];
  }
}

- (void)documentReferenceSnapshotApp:(nonnull PigeonFirebaseApp *)app
                          parameters:(nonnull DocumentReferenceRequest *)parameters
              includeMetadataChanges:(nonnull NSNumber *)includeMetadataChanges
                          completion:(nonnull void (^)(NSString *_Nullable,
                                                       FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRDocumentReference *document = [firestore documentWithPath:parameters.path];
  FIRServerTimestampBehavior serverTimestampBehavior =
      [PigeonParser parseServerTimestampBehavior:parameters.serverTimestampBehavior];

  completion(
      [self registerEventChannelWithPrefix:kFLTFirebaseFirestoreDocumentSnapshotEventChannelName
                             streamHandler:[[FLTDocumentSnapshotStreamHandler alloc]
                                                     initWithFirestore:firestore
                                                             reference:document
                                                includeMetadataChanges:includeMetadataChanges
                                                                           .boolValue
                                               serverTimestampBehavior:serverTimestampBehavior]],
      nil);
}

- (void)documentReferenceUpdateApp:(nonnull PigeonFirebaseApp *)app
                           request:(nonnull DocumentReferenceRequest *)request
                        completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  id data = request.data;
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRDocumentReference *document = [firestore documentWithPath:request.path];

  [document updateData:data
            completion:^(NSError *error) {
              if (error != nil) {
                completion([self convertToFlutterError:error]);
              } else {
                completion(nil);
              }
            }];
}

- (void)enableNetworkApp:(nonnull PigeonFirebaseApp *)app
              completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  [firestore enableNetworkWithCompletion:^(NSError *error) {
    if (error != nil) {
      completion([self convertToFlutterError:error]);
    } else {
      completion(nil);
    }
  }];
}

- (void)loadBundleApp:(nonnull PigeonFirebaseApp *)app
               bundle:(nonnull FlutterStandardTypedData *)bundle
           completion:(nonnull void (^)(NSString *_Nullable, FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];

  completion([self registerEventChannelWithPrefix:kFLTFirebaseFirestoreLoadBundleChannelName
                                    streamHandler:[[FLTLoadBundleStreamHandler alloc]
                                                      initWithFirestore:firestore
                                                                 bundle:bundle]],
             nil);
}

- (void)namedQueryGetApp:(nonnull PigeonFirebaseApp *)app
                    name:(nonnull NSString *)name
                 options:(nonnull PigeonGetOptions *)options
              completion:(nonnull void (^)(PigeonQuerySnapshot *_Nullable,
                                           FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];

  FIRFirestoreSource source = [PigeonParser parseSource:options.source];
  FIRServerTimestampBehavior serverTimestampBehavior =
      [PigeonParser parseServerTimestampBehavior:options.serverTimestampBehavior];

  [firestore
      getQueryNamed:name
         completion:^(FIRQuery *_Nullable query) {
           if (query == nil) {
             completion(nil,
                        [FlutterError errorWithCode:@"non-existent-named-query"
                                            message:@"Named query has not been found. Please check "
                                                    @"it has been loaded properly via loadBundle()."
                                            details:nil]);

             return;
           }
           [query getDocumentsWithSource:source
                              completion:^(FIRQuerySnapshot *_Nullable snapshot,
                                           NSError *_Nullable error) {
                                if (error != nil) {
                                  completion(nil, [self convertToFlutterError:error]);
                                } else {
                                  completion(
                                      [PigeonParser toPigeonQuerySnapshot:snapshot
                                                  serverTimestampBehavior:serverTimestampBehavior],
                                      nil);
                                }
                              }];
         }];
}

- (void)queryGetApp:(nonnull PigeonFirebaseApp *)app
                 path:(nonnull NSString *)path
    isCollectionGroup:(nonnull NSNumber *)isCollectionGroup
           parameters:(nonnull PigeonQueryParameters *)parameters
              options:(nonnull PigeonGetOptions *)options
           completion:(nonnull void (^)(PigeonQuerySnapshot *_Nullable,
                                        FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRQuery *query = [PigeonParser parseQueryWithParameters:parameters
                                                 firestore:firestore
                                                      path:path
                                         isCollectionGroup:[isCollectionGroup boolValue]];
  FIRFirestoreSource source = [PigeonParser parseSource:options.source];
  FIRServerTimestampBehavior serverTimestampBehavior =
      [PigeonParser parseServerTimestampBehavior:options.serverTimestampBehavior];

  [query getDocumentsWithSource:source
                     completion:^(FIRQuerySnapshot *_Nullable snapshot, NSError *_Nullable error) {
                       if (error != nil) {
                         completion(nil, [self convertToFlutterError:error]);
                       } else {
                         completion([PigeonParser toPigeonQuerySnapshot:snapshot
                                                serverTimestampBehavior:serverTimestampBehavior],
                                    nil);
                       }
                     }];
}

- (void)querySnapshotApp:(nonnull PigeonFirebaseApp *)app
                      path:(nonnull NSString *)path
         isCollectionGroup:(nonnull NSNumber *)isCollectionGroup
                parameters:(nonnull PigeonQueryParameters *)parameters
                   options:(nonnull PigeonGetOptions *)options
    includeMetadataChanges:(nonnull NSNumber *)includeMetadataChanges
                completion:
                    (nonnull void (^)(NSString *_Nullable, FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRQuery *query = [PigeonParser parseQueryWithParameters:parameters
                                                 firestore:firestore
                                                      path:path
                                         isCollectionGroup:[isCollectionGroup boolValue]];
  FIRServerTimestampBehavior serverTimestampBehavior =
      [PigeonParser parseServerTimestampBehavior:options.serverTimestampBehavior];

  completion([self
      registerEventChannelWithPrefix:kFLTFirebaseFirestoreQuerySnapshotEventChannelName
                       streamHandler:[[FLTQuerySnapshotStreamHandler alloc]
                                               initWithFirestore:firestore
                                                           query:query
                                          includeMetadataChanges:includeMetadataChanges.boolValue
                                         serverTimestampBehavior:serverTimestampBehavior],
                                     nil]);
}

- (void)setIndexConfigurationApp:(nonnull PigeonFirebaseApp *)app
              indexConfiguration:(nonnull NSString *)indexConfiguration
                      completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];

  [firestore setIndexConfigurationFromJSON:indexConfiguration
                                completion:^(NSError *_Nullable error) {
                                  if (error != nil) {
                                    completion([self convertToFlutterError:error]);
                                  } else {
                                    completion(nil);
                                  }
                                }];
}

- (void)setLoggingEnabledLoggingEnabled:(nonnull NSNumber *)loggingEnabled
                             completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  [FIRFirestore enableLogging:[loggingEnabled boolValue]];
  completion(nil);
}

- (void)snapshotsInSyncSetupWithCompletion:(nonnull void (^)(NSString *_Nullable,
                                                             FlutterError *_Nullable))completion {
  completion(
      [self registerEventChannelWithPrefix:kFLTFirebaseFirestoreSnapshotsInSyncEventChannelName
                             streamHandler:[FLTSnapshotsInSyncStreamHandler new]],
      nil);
}

- (void)terminateApp:(nonnull PigeonFirebaseApp *)app
          completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  [firestore terminateWithCompletion:^(NSError *error) {
    if (error != nil) {
      completion([self convertToFlutterError:error]);
    } else {
      [FLTFirebaseFirestoreUtils destroyCachedFIRFirestoreInstanceForKey:firestore.app.name];
      completion(nil);
    }
  }];
}

- (void)transactionCreateWithCompletion:(nonnull void (^)(NSString *_Nullable,
                                                          FlutterError *_Nullable))completion {
  NSString *transactionId = [[[NSUUID UUID] UUIDString] lowercaseString];

  FLTTransactionStreamHandler *handler =
      [[FLTTransactionStreamHandler alloc] initWithId:transactionId
          started:^(FIRTransaction *_Nonnull transaction) {
            self->_transactions[transactionId] = transaction;
          }
          ended:^{
            self->_transactions[transactionId] = nil;
          }];

  _transactionHandlers[transactionId] = handler;

  completion([self registerEventChannelWithPrefix:kFLTFirebaseFirestoreTransactionChannelName
                                       identifier:transactionId
                                    streamHandler:handler],
             nil);
}

- (void)transactionGetApp:(nonnull PigeonFirebaseApp *)app
            transactionId:(nonnull NSString *)transactionId
                     path:(nonnull NSString *)path
               completion:(nonnull void (^)(PigeonDocumentSnapshot *_Nullable,
                                            FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRDocumentReference *document = [firestore documentWithPath:path];

  FIRTransaction *transaction = self->_transactions[transactionId];

  if (transaction == nil) {
    completion(
        nil,
        [FlutterError
            errorWithCode:@"missing-transaction"
                  message:@"An error occurred while getting the native transaction. "
                          @"It could be caused by a timeout in a preceding transaction operation."
                  details:nil]);
    return;
  }

  NSError *error = [[NSError alloc] init];
  FIRDocumentSnapshot *snapshot = [transaction getDocument:document error:&error];

  if (error != nil) {
    completion(nil, [self convertToFlutterError:error]);
  } else if (snapshot != nil) {
    completion([PigeonParser toPigeonDocumentSnapshot:snapshot
                              serverTimestampBehavior:FIRServerTimestampBehaviorNone],
               nil);
  } else {
    completion(nil, nil);
  }
}

- (void)transactionStoreResultTransactionId:(nonnull NSString *)transactionId
                                 resultType:(PigeonTransactionResult)resultType
                                   commands:(nullable NSArray<PigeonTransactionCommand *> *)commands
                                 completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  [_transactionHandlers[transactionId] receiveTransactionResponse:resultType commands:commands];

  completion(nil);
}

- (void)waitForPendingWritesApp:(nonnull PigeonFirebaseApp *)app
                     completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  [firestore waitForPendingWritesWithCompletion:^(NSError *error) {
    if (error != nil) {
      completion([self convertToFlutterError:error]);
    } else {
      completion(nil);
    }
  }];
}

- (void)writeBatchCommitApp:(nonnull PigeonFirebaseApp *)app
                     writes:(nonnull NSArray<PigeonTransactionCommand *> *)writes
                 completion:(nonnull void (^)(FlutterError *_Nullable))completion {
  FIRFirestore *firestore = [self getFIRFirestoreFromAppNameFromPigeon:app];
  FIRWriteBatch *batch = [firestore batch];

  for (PigeonTransactionCommand *write in writes) {
    PigeonTransactionType type = write.type;
    NSString *path = write.path;
    FIRDocumentReference *reference = [firestore documentWithPath:path];

    switch (type) {
      case PigeonTransactionTypeGet:
        break;
      case PigeonTransactionTypeDelete:
        [batch deleteDocument:reference];
        break;
      case PigeonTransactionTypeUpdate:
        [batch updateData:write.data forDocument:reference];
        break;
      case PigeonTransactionTypeSet:
        if ([write.option.merge isEqual:@YES]) {
          [batch setData:write.data forDocument:reference merge:YES];
        } else if (![write.option.mergeFields isEqual:[NSNull null]]) {
          [batch setData:write.data forDocument:reference mergeFields:write.option.mergeFields];
        } else {
          [batch setData:write.data forDocument:reference];
        }
        break;
    }
  }

  [batch commitWithCompletion:^(NSError *error) {
    if (error != nil) {
      completion([self convertToFlutterError:error]);
    } else {
      completion(nil);
    }
  }];
}

@end
