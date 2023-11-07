// Copyright 2023, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "firebase_storage_messages.g.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

/// The type of operation that generated the action code from calling
/// [TaskState].
@implementation PigeonStorageTaskStateBox
- (instancetype)initWithValue:(PigeonStorageTaskState)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface PigeonStorageFirebaseApp ()
+ (PigeonStorageFirebaseApp *)fromList:(NSArray *)list;
+ (nullable PigeonStorageFirebaseApp *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface PigeonStorageReference ()
+ (PigeonStorageReference *)fromList:(NSArray *)list;
+ (nullable PigeonStorageReference *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface PigeonFullMetaData ()
+ (PigeonFullMetaData *)fromList:(NSArray *)list;
+ (nullable PigeonFullMetaData *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface PigeonListOptions ()
+ (PigeonListOptions *)fromList:(NSArray *)list;
+ (nullable PigeonListOptions *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface PigeonSettableMetadata ()
+ (PigeonSettableMetadata *)fromList:(NSArray *)list;
+ (nullable PigeonSettableMetadata *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface PigeonListResult ()
+ (PigeonListResult *)fromList:(NSArray *)list;
+ (nullable PigeonListResult *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation PigeonStorageFirebaseApp
+ (instancetype)makeWithAppName:(NSString *)appName
    tenantId:(nullable NSString *)tenantId
    bucket:(NSString *)bucket {
  PigeonStorageFirebaseApp* pigeonResult = [[PigeonStorageFirebaseApp alloc] init];
  pigeonResult.appName = appName;
  pigeonResult.tenantId = tenantId;
  pigeonResult.bucket = bucket;
  return pigeonResult;
}
+ (PigeonStorageFirebaseApp *)fromList:(NSArray *)list {
  PigeonStorageFirebaseApp *pigeonResult = [[PigeonStorageFirebaseApp alloc] init];
  pigeonResult.appName = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.appName != nil, @"");
  pigeonResult.tenantId = GetNullableObjectAtIndex(list, 1);
  pigeonResult.bucket = GetNullableObjectAtIndex(list, 2);
  NSAssert(pigeonResult.bucket != nil, @"");
  return pigeonResult;
}
+ (nullable PigeonStorageFirebaseApp *)nullableFromList:(NSArray *)list {
  return (list) ? [PigeonStorageFirebaseApp fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.appName ?: [NSNull null]),
    (self.tenantId ?: [NSNull null]),
    (self.bucket ?: [NSNull null]),
  ];
}
@end

@implementation PigeonStorageReference
+ (instancetype)makeWithBucket:(NSString *)bucket
    fullPath:(NSString *)fullPath
    name:(NSString *)name {
  PigeonStorageReference* pigeonResult = [[PigeonStorageReference alloc] init];
  pigeonResult.bucket = bucket;
  pigeonResult.fullPath = fullPath;
  pigeonResult.name = name;
  return pigeonResult;
}
+ (PigeonStorageReference *)fromList:(NSArray *)list {
  PigeonStorageReference *pigeonResult = [[PigeonStorageReference alloc] init];
  pigeonResult.bucket = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.bucket != nil, @"");
  pigeonResult.fullPath = GetNullableObjectAtIndex(list, 1);
  NSAssert(pigeonResult.fullPath != nil, @"");
  pigeonResult.name = GetNullableObjectAtIndex(list, 2);
  NSAssert(pigeonResult.name != nil, @"");
  return pigeonResult;
}
+ (nullable PigeonStorageReference *)nullableFromList:(NSArray *)list {
  return (list) ? [PigeonStorageReference fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.bucket ?: [NSNull null]),
    (self.fullPath ?: [NSNull null]),
    (self.name ?: [NSNull null]),
  ];
}
@end

@implementation PigeonFullMetaData
+ (instancetype)makeWithMetadata:(nullable NSDictionary<NSString *, id> *)metadata {
  PigeonFullMetaData* pigeonResult = [[PigeonFullMetaData alloc] init];
  pigeonResult.metadata = metadata;
  return pigeonResult;
}
+ (PigeonFullMetaData *)fromList:(NSArray *)list {
  PigeonFullMetaData *pigeonResult = [[PigeonFullMetaData alloc] init];
  pigeonResult.metadata = GetNullableObjectAtIndex(list, 0);
  return pigeonResult;
}
+ (nullable PigeonFullMetaData *)nullableFromList:(NSArray *)list {
  return (list) ? [PigeonFullMetaData fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.metadata ?: [NSNull null]),
  ];
}
@end

@implementation PigeonListOptions
+ (instancetype)makeWithMaxResults:(nullable NSNumber *)maxResults
    pageToken:(nullable NSString *)pageToken {
  PigeonListOptions* pigeonResult = [[PigeonListOptions alloc] init];
  pigeonResult.maxResults = maxResults;
  pigeonResult.pageToken = pageToken;
  return pigeonResult;
}
+ (PigeonListOptions *)fromList:(NSArray *)list {
  PigeonListOptions *pigeonResult = [[PigeonListOptions alloc] init];
  pigeonResult.maxResults = GetNullableObjectAtIndex(list, 0);
  pigeonResult.pageToken = GetNullableObjectAtIndex(list, 1);
  return pigeonResult;
}
+ (nullable PigeonListOptions *)nullableFromList:(NSArray *)list {
  return (list) ? [PigeonListOptions fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.maxResults ?: [NSNull null]),
    (self.pageToken ?: [NSNull null]),
  ];
}
@end

@implementation PigeonSettableMetadata
+ (instancetype)makeWithCacheControl:(nullable NSString *)cacheControl
    contentDisposition:(nullable NSString *)contentDisposition
    contentEncoding:(nullable NSString *)contentEncoding
    contentLanguage:(nullable NSString *)contentLanguage
    contentType:(nullable NSString *)contentType
    customMetadata:(nullable NSDictionary<NSString *, NSString *> *)customMetadata {
  PigeonSettableMetadata* pigeonResult = [[PigeonSettableMetadata alloc] init];
  pigeonResult.cacheControl = cacheControl;
  pigeonResult.contentDisposition = contentDisposition;
  pigeonResult.contentEncoding = contentEncoding;
  pigeonResult.contentLanguage = contentLanguage;
  pigeonResult.contentType = contentType;
  pigeonResult.customMetadata = customMetadata;
  return pigeonResult;
}
+ (PigeonSettableMetadata *)fromList:(NSArray *)list {
  PigeonSettableMetadata *pigeonResult = [[PigeonSettableMetadata alloc] init];
  pigeonResult.cacheControl = GetNullableObjectAtIndex(list, 0);
  pigeonResult.contentDisposition = GetNullableObjectAtIndex(list, 1);
  pigeonResult.contentEncoding = GetNullableObjectAtIndex(list, 2);
  pigeonResult.contentLanguage = GetNullableObjectAtIndex(list, 3);
  pigeonResult.contentType = GetNullableObjectAtIndex(list, 4);
  pigeonResult.customMetadata = GetNullableObjectAtIndex(list, 5);
  return pigeonResult;
}
+ (nullable PigeonSettableMetadata *)nullableFromList:(NSArray *)list {
  return (list) ? [PigeonSettableMetadata fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.cacheControl ?: [NSNull null]),
    (self.contentDisposition ?: [NSNull null]),
    (self.contentEncoding ?: [NSNull null]),
    (self.contentLanguage ?: [NSNull null]),
    (self.contentType ?: [NSNull null]),
    (self.customMetadata ?: [NSNull null]),
  ];
}
@end

@implementation PigeonListResult
+ (instancetype)makeWithItems:(NSArray<PigeonStorageReference *> *)items
    pageToken:(nullable NSString *)pageToken
    prefixs:(NSArray<PigeonStorageReference *> *)prefixs {
  PigeonListResult* pigeonResult = [[PigeonListResult alloc] init];
  pigeonResult.items = items;
  pigeonResult.pageToken = pageToken;
  pigeonResult.prefixs = prefixs;
  return pigeonResult;
}
+ (PigeonListResult *)fromList:(NSArray *)list {
  PigeonListResult *pigeonResult = [[PigeonListResult alloc] init];
  pigeonResult.items = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.items != nil, @"");
  pigeonResult.pageToken = GetNullableObjectAtIndex(list, 1);
  pigeonResult.prefixs = GetNullableObjectAtIndex(list, 2);
  NSAssert(pigeonResult.prefixs != nil, @"");
  return pigeonResult;
}
+ (nullable PigeonListResult *)nullableFromList:(NSArray *)list {
  return (list) ? [PigeonListResult fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.items ?: [NSNull null]),
    (self.pageToken ?: [NSNull null]),
    (self.prefixs ?: [NSNull null]),
  ];
}
@end

@interface FirebaseStorageHostApiCodecReader : FlutterStandardReader
@end
@implementation FirebaseStorageHostApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128: 
      return [PigeonFullMetaData fromList:[self readValue]];
    case 129: 
      return [PigeonListOptions fromList:[self readValue]];
    case 130: 
      return [PigeonListResult fromList:[self readValue]];
    case 131: 
      return [PigeonSettableMetadata fromList:[self readValue]];
    case 132: 
      return [PigeonStorageFirebaseApp fromList:[self readValue]];
    case 133: 
      return [PigeonStorageReference fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface FirebaseStorageHostApiCodecWriter : FlutterStandardWriter
@end
@implementation FirebaseStorageHostApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[PigeonFullMetaData class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[PigeonListOptions class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[PigeonListResult class]]) {
    [self writeByte:130];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[PigeonSettableMetadata class]]) {
    [self writeByte:131];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[PigeonStorageFirebaseApp class]]) {
    [self writeByte:132];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[PigeonStorageReference class]]) {
    [self writeByte:133];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface FirebaseStorageHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FirebaseStorageHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FirebaseStorageHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FirebaseStorageHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FirebaseStorageHostApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    FirebaseStorageHostApiCodecReaderWriter *readerWriter = [[FirebaseStorageHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void FirebaseStorageHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FirebaseStorageHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.getReferencebyPath"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getReferencebyPathApp:path:bucket:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(getReferencebyPathApp:path:bucket:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        NSString *arg_path = GetNullableObjectAtIndex(args, 1);
        NSString *arg_bucket = GetNullableObjectAtIndex(args, 2);
        [api getReferencebyPathApp:arg_app path:arg_path bucket:arg_bucket completion:^(PigeonStorageReference *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.setMaxOperationRetryTime"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setMaxOperationRetryTimeApp:time:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(setMaxOperationRetryTimeApp:time:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_time = GetNullableObjectAtIndex(args, 1);
        [api setMaxOperationRetryTimeApp:arg_app time:arg_time completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.setMaxUploadRetryTime"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setMaxUploadRetryTimeApp:time:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(setMaxUploadRetryTimeApp:time:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_time = GetNullableObjectAtIndex(args, 1);
        [api setMaxUploadRetryTimeApp:arg_app time:arg_time completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.setMaxDownloadRetryTime"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setMaxDownloadRetryTimeApp:time:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(setMaxDownloadRetryTimeApp:time:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_time = GetNullableObjectAtIndex(args, 1);
        [api setMaxDownloadRetryTimeApp:arg_app time:arg_time completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.useStorageEmulator"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(useStorageEmulatorApp:host:port:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(useStorageEmulatorApp:host:port:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        NSString *arg_host = GetNullableObjectAtIndex(args, 1);
        NSNumber *arg_port = GetNullableObjectAtIndex(args, 2);
        [api useStorageEmulatorApp:arg_app host:arg_host port:arg_port completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referenceDelete"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referenceDeleteApp:reference:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referenceDeleteApp:reference:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        [api referenceDeleteApp:arg_app reference:arg_reference completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referenceGetDownloadURL"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referenceGetDownloadURLApp:reference:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referenceGetDownloadURLApp:reference:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        [api referenceGetDownloadURLApp:arg_app reference:arg_reference completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referenceGetMetaData"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referenceGetMetaDataApp:reference:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referenceGetMetaDataApp:reference:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        [api referenceGetMetaDataApp:arg_app reference:arg_reference completion:^(PigeonFullMetaData *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referenceList"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referenceListApp:reference:options:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referenceListApp:reference:options:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        PigeonListOptions *arg_options = GetNullableObjectAtIndex(args, 2);
        [api referenceListApp:arg_app reference:arg_reference options:arg_options completion:^(PigeonListResult *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referenceListAll"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referenceListAllApp:reference:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referenceListAllApp:reference:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        [api referenceListAllApp:arg_app reference:arg_reference completion:^(PigeonListResult *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referenceGetData"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referenceGetDataApp:reference:maxSize:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referenceGetDataApp:reference:maxSize:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        NSNumber *arg_maxSize = GetNullableObjectAtIndex(args, 2);
        [api referenceGetDataApp:arg_app reference:arg_reference maxSize:arg_maxSize completion:^(FlutterStandardTypedData *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referencePutData"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referencePutDataApp:reference:data:settableMetaData:handle:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referencePutDataApp:reference:data:settableMetaData:handle:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        FlutterStandardTypedData *arg_data = GetNullableObjectAtIndex(args, 2);
        PigeonSettableMetadata *arg_settableMetaData = GetNullableObjectAtIndex(args, 3);
        NSNumber *arg_handle = GetNullableObjectAtIndex(args, 4);
        [api referencePutDataApp:arg_app reference:arg_reference data:arg_data settableMetaData:arg_settableMetaData handle:arg_handle completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referencePutString"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referencePutStringApp:reference:data:format:settableMetaData:handle:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referencePutStringApp:reference:data:format:settableMetaData:handle:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        NSString *arg_data = GetNullableObjectAtIndex(args, 2);
        NSNumber *arg_format = GetNullableObjectAtIndex(args, 3);
        PigeonSettableMetadata *arg_settableMetaData = GetNullableObjectAtIndex(args, 4);
        NSNumber *arg_handle = GetNullableObjectAtIndex(args, 5);
        [api referencePutStringApp:arg_app reference:arg_reference data:arg_data format:arg_format settableMetaData:arg_settableMetaData handle:arg_handle completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referencePutFile"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referencePutFileApp:reference:filePath:settableMetaData:handle:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referencePutFileApp:reference:filePath:settableMetaData:handle:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        NSString *arg_filePath = GetNullableObjectAtIndex(args, 2);
        PigeonSettableMetadata *arg_settableMetaData = GetNullableObjectAtIndex(args, 3);
        NSNumber *arg_handle = GetNullableObjectAtIndex(args, 4);
        [api referencePutFileApp:arg_app reference:arg_reference filePath:arg_filePath settableMetaData:arg_settableMetaData handle:arg_handle completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referenceDownloadFile"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referenceDownloadFileApp:reference:filePath:handle:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referenceDownloadFileApp:reference:filePath:handle:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        NSString *arg_filePath = GetNullableObjectAtIndex(args, 2);
        NSNumber *arg_handle = GetNullableObjectAtIndex(args, 3);
        [api referenceDownloadFileApp:arg_app reference:arg_reference filePath:arg_filePath handle:arg_handle completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.referenceUpdateMetadata"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(referenceUpdateMetadataApp:reference:metadata:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(referenceUpdateMetadataApp:reference:metadata:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        PigeonStorageReference *arg_reference = GetNullableObjectAtIndex(args, 1);
        PigeonSettableMetadata *arg_metadata = GetNullableObjectAtIndex(args, 2);
        [api referenceUpdateMetadataApp:arg_app reference:arg_reference metadata:arg_metadata completion:^(PigeonFullMetaData *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.taskPause"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(taskPauseApp:handle:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(taskPauseApp:handle:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_handle = GetNullableObjectAtIndex(args, 1);
        [api taskPauseApp:arg_app handle:arg_handle completion:^(NSDictionary<NSString *, id> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.taskResume"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(taskResumeApp:handle:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(taskResumeApp:handle:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_handle = GetNullableObjectAtIndex(args, 1);
        [api taskResumeApp:arg_app handle:arg_handle completion:^(NSDictionary<NSString *, id> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.firebase_storage_platform_interface.FirebaseStorageHostApi.taskCancel"
        binaryMessenger:binaryMessenger
        codec:FirebaseStorageHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(taskCancelApp:handle:completion:)], @"FirebaseStorageHostApi api (%@) doesn't respond to @selector(taskCancelApp:handle:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonStorageFirebaseApp *arg_app = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_handle = GetNullableObjectAtIndex(args, 1);
        [api taskCancelApp:arg_app handle:arg_handle completion:^(NSDictionary<NSString *, id> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
