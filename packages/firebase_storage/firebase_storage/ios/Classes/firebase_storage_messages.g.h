// Copyright 2023, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

/// The type of operation that generated the action code from calling
/// [TaskState].
typedef NS_ENUM(NSUInteger, PigeonStorageTaskState) {
  /// Indicates the task has been paused by the user.
  PigeonStorageTaskStatePaused = 0,
  /// Indicates the task is currently in-progress.
  PigeonStorageTaskStateRunning = 1,
  /// Indicates the task has successfully completed.
  PigeonStorageTaskStateSuccess = 2,
  /// Indicates the task was canceled.
  PigeonStorageTaskStateCanceled = 3,
  /// Indicates the task failed with an error.
  PigeonStorageTaskStateError = 4,
};

/// Wrapper for PigeonStorageTaskState to allow for nullability.
@interface PigeonStorageTaskStateBox : NSObject
@property(nonatomic, assign) PigeonStorageTaskState value;
- (instancetype)initWithValue:(PigeonStorageTaskState)value;
@end

@class PigeonStorageFirebaseApp;
@class PigeonStorageReference;
@class PigeonFullMetaData;
@class PigeonListOptions;
@class PigeonSettableMetadata;
@class PigeonListResult;

@interface PigeonStorageFirebaseApp : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithAppName:(NSString *)appName
    tenantId:(nullable NSString *)tenantId
    bucket:(NSString *)bucket;
@property(nonatomic, copy) NSString * appName;
@property(nonatomic, copy, nullable) NSString * tenantId;
@property(nonatomic, copy) NSString * bucket;
@end

@interface PigeonStorageReference : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithBucket:(NSString *)bucket
    fullPath:(NSString *)fullPath
    name:(NSString *)name;
@property(nonatomic, copy) NSString * bucket;
@property(nonatomic, copy) NSString * fullPath;
@property(nonatomic, copy) NSString * name;
@end

@interface PigeonFullMetaData : NSObject
+ (instancetype)makeWithMetadata:(nullable NSDictionary<NSString *, id> *)metadata;
@property(nonatomic, strong, nullable) NSDictionary<NSString *, id> * metadata;
@end

@interface PigeonListOptions : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithMaxResults:(NSNumber *)maxResults
    pageToken:(nullable NSString *)pageToken;
/// If set, limits the total number of `prefixes` and `items` to return.
///
/// The default and maximum maxResults is 1000.
@property(nonatomic, strong) NSNumber * maxResults;
/// The nextPageToken from a previous call to list().
///
/// If provided, listing is resumed from the previous position.
@property(nonatomic, copy, nullable) NSString * pageToken;
@end

@interface PigeonSettableMetadata : NSObject
+ (instancetype)makeWithCacheControl:(nullable NSString *)cacheControl
    contentDisposition:(nullable NSString *)contentDisposition
    contentEncoding:(nullable NSString *)contentEncoding
    contentLanguage:(nullable NSString *)contentLanguage
    contentType:(nullable NSString *)contentType
    customMetadata:(nullable NSDictionary<NSString *, NSString *> *)customMetadata;
/// Served as the 'Cache-Control' header on object download.
///
/// See https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control.
@property(nonatomic, copy, nullable) NSString * cacheControl;
/// Served as the 'Content-Disposition' header on object download.
///
/// See https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Disposition.
@property(nonatomic, copy, nullable) NSString * contentDisposition;
/// Served as the 'Content-Encoding' header on object download.
///
/// See https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding.
@property(nonatomic, copy, nullable) NSString * contentEncoding;
/// Served as the 'Content-Language' header on object download.
///
/// See https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Language.
@property(nonatomic, copy, nullable) NSString * contentLanguage;
/// Served as the 'Content-Type' header on object download.
///
/// See https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type.
@property(nonatomic, copy, nullable) NSString * contentType;
/// Additional user-defined custom metadata.
@property(nonatomic, strong, nullable) NSDictionary<NSString *, NSString *> * customMetadata;
@end

@interface PigeonListResult : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithItems:(NSArray<PigeonStorageReference *> *)items
    pageToken:(nullable NSString *)pageToken
    prefixs:(NSArray<PigeonStorageReference *> *)prefixs;
@property(nonatomic, strong) NSArray<PigeonStorageReference *> * items;
@property(nonatomic, copy, nullable) NSString * pageToken;
@property(nonatomic, strong) NSArray<PigeonStorageReference *> * prefixs;
@end

/// The codec used by FirebaseStorageHostApi.
NSObject<FlutterMessageCodec> *FirebaseStorageHostApiGetCodec(void);

@protocol FirebaseStorageHostApi
- (void)getReferencebyPathApp:(PigeonStorageFirebaseApp *)app path:(NSString *)path bucket:(nullable NSString *)bucket completion:(void (^)(PigeonStorageReference *_Nullable, FlutterError *_Nullable))completion;
- (void)setMaxOperationRetryTimeApp:(PigeonStorageFirebaseApp *)app time:(NSNumber *)time completion:(void (^)(FlutterError *_Nullable))completion;
- (void)setMaxUploadRetryTimeApp:(PigeonStorageFirebaseApp *)app time:(NSNumber *)time completion:(void (^)(FlutterError *_Nullable))completion;
- (void)setMaxDownloadRetryTimeApp:(PigeonStorageFirebaseApp *)app time:(NSNumber *)time completion:(void (^)(FlutterError *_Nullable))completion;
- (void)useStorageEmulatorApp:(PigeonStorageFirebaseApp *)app host:(NSString *)host port:(NSNumber *)port completion:(void (^)(FlutterError *_Nullable))completion;
- (void)referenceDeleteApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference completion:(void (^)(FlutterError *_Nullable))completion;
- (void)referenceGetDownloadURLApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)referenceGetMetaDataApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference completion:(void (^)(PigeonFullMetaData *_Nullable, FlutterError *_Nullable))completion;
- (void)referenceListApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference options:(PigeonListOptions *)options completion:(void (^)(PigeonListResult *_Nullable, FlutterError *_Nullable))completion;
- (void)referenceListAllApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference completion:(void (^)(PigeonListResult *_Nullable, FlutterError *_Nullable))completion;
- (void)referenceGetDataApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference maxSize:(NSNumber *)maxSize completion:(void (^)(FlutterStandardTypedData *_Nullable, FlutterError *_Nullable))completion;
- (void)referencePutDataApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference data:(FlutterStandardTypedData *)data settableMetaData:(PigeonSettableMetadata *)settableMetaData handle:(NSNumber *)handle completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)referencePutStringApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference data:(NSString *)data format:(NSNumber *)format settableMetaData:(PigeonSettableMetadata *)settableMetaData handle:(NSNumber *)handle completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)referencePutFileApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference filePath:(NSString *)filePath settableMetaData:(PigeonSettableMetadata *)settableMetaData handle:(NSNumber *)handle completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)referenceDownloadFileApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference filePath:(NSString *)filePath handle:(NSNumber *)handle completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)referenceUpdateMetadataApp:(PigeonStorageFirebaseApp *)app reference:(PigeonStorageReference *)reference metadata:(PigeonSettableMetadata *)metadata completion:(void (^)(PigeonFullMetaData *_Nullable, FlutterError *_Nullable))completion;
- (void)taskPauseApp:(PigeonStorageFirebaseApp *)app handle:(NSNumber *)handle completion:(void (^)(NSDictionary<NSString *, id> *_Nullable, FlutterError *_Nullable))completion;
- (void)taskResumeApp:(PigeonStorageFirebaseApp *)app handle:(NSNumber *)handle completion:(void (^)(NSDictionary<NSString *, id> *_Nullable, FlutterError *_Nullable))completion;
- (void)taskCancelApp:(PigeonStorageFirebaseApp *)app handle:(NSNumber *)handle completion:(void (^)(NSDictionary<NSString *, id> *_Nullable, FlutterError *_Nullable))completion;
@end

extern void FirebaseStorageHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FirebaseStorageHostApi> *_Nullable api);

NS_ASSUME_NONNULL_END
