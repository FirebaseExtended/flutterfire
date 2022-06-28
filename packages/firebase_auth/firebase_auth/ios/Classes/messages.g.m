// Autogenerated from Pigeon (v3.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "messages.g.h"
#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
      @"code" : (error.code ?: [NSNull null]),
      @"message" : (error.message ?: [NSNull null]),
      @"details" : (error.details ?: [NSNull null]),
    };
  }
  return @{
    @"result" : (result ?: [NSNull null]),
    @"error" : errorDict,
  };
}
static id GetNullableObject(NSDictionary *dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface PigeonMultiFactorSession ()
+ (PigeonMultiFactorSession *)fromMap:(NSDictionary *)dict;
+ (nullable PigeonMultiFactorSession *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface PigeonPhoneMultiFactorAssertion ()
+ (PigeonPhoneMultiFactorAssertion *)fromMap:(NSDictionary *)dict;
+ (nullable PigeonPhoneMultiFactorAssertion *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface PigeonMultiFactorInfo ()
+ (PigeonMultiFactorInfo *)fromMap:(NSDictionary *)dict;
+ (nullable PigeonMultiFactorInfo *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end

@implementation PigeonMultiFactorSession
+ (instancetype)makeWithId:(NSString *)id {
  PigeonMultiFactorSession *pigeonResult = [[PigeonMultiFactorSession alloc] init];
  pigeonResult.id = id;
  return pigeonResult;
}
+ (PigeonMultiFactorSession *)fromMap:(NSDictionary *)dict {
  PigeonMultiFactorSession *pigeonResult = [[PigeonMultiFactorSession alloc] init];
  pigeonResult.id = GetNullableObject(dict, @"id");
  NSAssert(pigeonResult.id != nil, @"");
  return pigeonResult;
}
+ (nullable PigeonMultiFactorSession *)nullableFromMap:(NSDictionary *)dict {
  return (dict) ? [PigeonMultiFactorSession fromMap:dict] : nil;
}
- (NSDictionary *)toMap {
  return @{
    @"id" : (self.id ?: [NSNull null]),
  };
}
@end

@implementation PigeonPhoneMultiFactorAssertion
+ (instancetype)makeWithVerificationId:(NSString *)verificationId
                      verificationCode:(NSString *)verificationCode {
  PigeonPhoneMultiFactorAssertion *pigeonResult = [[PigeonPhoneMultiFactorAssertion alloc] init];
  pigeonResult.verificationId = verificationId;
  pigeonResult.verificationCode = verificationCode;
  return pigeonResult;
}
+ (PigeonPhoneMultiFactorAssertion *)fromMap:(NSDictionary *)dict {
  PigeonPhoneMultiFactorAssertion *pigeonResult = [[PigeonPhoneMultiFactorAssertion alloc] init];
  pigeonResult.verificationId = GetNullableObject(dict, @"verificationId");
  NSAssert(pigeonResult.verificationId != nil, @"");
  pigeonResult.verificationCode = GetNullableObject(dict, @"verificationCode");
  NSAssert(pigeonResult.verificationCode != nil, @"");
  return pigeonResult;
}
+ (nullable PigeonPhoneMultiFactorAssertion *)nullableFromMap:(NSDictionary *)dict {
  return (dict) ? [PigeonPhoneMultiFactorAssertion fromMap:dict] : nil;
}
- (NSDictionary *)toMap {
  return @{
    @"verificationId" : (self.verificationId ?: [NSNull null]),
    @"verificationCode" : (self.verificationCode ?: [NSNull null]),
  };
}
@end

@implementation PigeonMultiFactorInfo
+ (instancetype)makeWithDisplayName:(nullable NSString *)displayName
                enrollmentTimestamp:(NSNumber *)enrollmentTimestamp
                           factorId:(NSString *)factorId
                                uid:(NSString *)uid
                        phoneNumber:(nullable NSString *)phoneNumber {
  PigeonMultiFactorInfo *pigeonResult = [[PigeonMultiFactorInfo alloc] init];
  pigeonResult.displayName = displayName;
  pigeonResult.enrollmentTimestamp = enrollmentTimestamp;
  pigeonResult.factorId = factorId;
  pigeonResult.uid = uid;
  pigeonResult.phoneNumber = phoneNumber;
  return pigeonResult;
}
+ (PigeonMultiFactorInfo *)fromMap:(NSDictionary *)dict {
  PigeonMultiFactorInfo *pigeonResult = [[PigeonMultiFactorInfo alloc] init];
  pigeonResult.displayName = GetNullableObject(dict, @"displayName");
  pigeonResult.enrollmentTimestamp = GetNullableObject(dict, @"enrollmentTimestamp");
  NSAssert(pigeonResult.enrollmentTimestamp != nil, @"");
  pigeonResult.factorId = GetNullableObject(dict, @"factorId");
  NSAssert(pigeonResult.factorId != nil, @"");
  pigeonResult.uid = GetNullableObject(dict, @"uid");
  NSAssert(pigeonResult.uid != nil, @"");
  pigeonResult.phoneNumber = GetNullableObject(dict, @"phoneNumber");
  return pigeonResult;
}
+ (nullable PigeonMultiFactorInfo *)nullableFromMap:(NSDictionary *)dict {
  return (dict) ? [PigeonMultiFactorInfo fromMap:dict] : nil;
}
- (NSDictionary *)toMap {
  return @{
    @"displayName" : (self.displayName ?: [NSNull null]),
    @"enrollmentTimestamp" : (self.enrollmentTimestamp ?: [NSNull null]),
    @"factorId" : (self.factorId ?: [NSNull null]),
    @"uid" : (self.uid ?: [NSNull null]),
    @"phoneNumber" : (self.phoneNumber ?: [NSNull null]),
  };
}
@end

@interface MultiFactorUserHostApiCodecReader : FlutterStandardReader
@end
@implementation MultiFactorUserHostApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128:
      return [PigeonMultiFactorInfo fromMap:[self readValue]];

    case 129:
      return [PigeonMultiFactorSession fromMap:[self readValue]];

    case 130:
      return [PigeonPhoneMultiFactorAssertion fromMap:[self readValue]];

    default:
      return [super readValueOfType:type];
  }
}
@end

@interface MultiFactorUserHostApiCodecWriter : FlutterStandardWriter
@end
@implementation MultiFactorUserHostApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[PigeonMultiFactorInfo class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else if ([value isKindOfClass:[PigeonMultiFactorSession class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else if ([value isKindOfClass:[PigeonPhoneMultiFactorAssertion class]]) {
    [self writeByte:130];
    [self writeValue:[value toMap]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface MultiFactorUserHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation MultiFactorUserHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[MultiFactorUserHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[MultiFactorUserHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *MultiFactorUserHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    MultiFactorUserHostApiCodecReaderWriter *readerWriter =
        [[MultiFactorUserHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void MultiFactorUserHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger,
                                 NSObject<MultiFactorUserHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.MultiFactorUserHostApi.enrollPhone"
        binaryMessenger:binaryMessenger
                  codec:MultiFactorUserHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(enrollPhoneAppName:
                                                           assertion:displayName:completion:)],
                @"MultiFactorUserHostApi api (%@) doesn't respond to "
                @"@selector(enrollPhoneAppName:assertion:displayName:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_appName = GetNullableObjectAtIndex(args, 0);
        PigeonPhoneMultiFactorAssertion *arg_assertion = GetNullableObjectAtIndex(args, 1);
        NSString *arg_displayName = GetNullableObjectAtIndex(args, 2);
        [api enrollPhoneAppName:arg_appName
                      assertion:arg_assertion
                    displayName:arg_displayName
                     completion:^(FlutterError *_Nullable error) {
                       callback(wrapResult(nil, error));
                     }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.MultiFactorUserHostApi.getSession"
        binaryMessenger:binaryMessenger
                  codec:MultiFactorUserHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getSessionAppName:completion:)],
                @"MultiFactorUserHostApi api (%@) doesn't respond to "
                @"@selector(getSessionAppName:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_appName = GetNullableObjectAtIndex(args, 0);
        [api getSessionAppName:arg_appName
                    completion:^(PigeonMultiFactorSession *_Nullable output,
                                 FlutterError *_Nullable error) {
                      callback(wrapResult(output, error));
                    }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.MultiFactorUserHostApi.unenroll"
        binaryMessenger:binaryMessenger
                  codec:MultiFactorUserHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(unenrollAppName:factorUid:completion:)],
                @"MultiFactorUserHostApi api (%@) doesn't respond to "
                @"@selector(unenrollAppName:factorUid:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_appName = GetNullableObjectAtIndex(args, 0);
        NSString *arg_factorUid = GetNullableObjectAtIndex(args, 1);
        [api unenrollAppName:arg_appName
                   factorUid:arg_factorUid
                  completion:^(FlutterError *_Nullable error) {
                    callback(wrapResult(nil, error));
                  }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.MultiFactorUserHostApi.getEnrolledFactors"
        binaryMessenger:binaryMessenger
                  codec:MultiFactorUserHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getEnrolledFactorsAppName:completion:)],
                @"MultiFactorUserHostApi api (%@) doesn't respond to "
                @"@selector(getEnrolledFactorsAppName:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_appName = GetNullableObjectAtIndex(args, 0);
        [api getEnrolledFactorsAppName:arg_appName
                            completion:^(NSArray<PigeonMultiFactorInfo *> *_Nullable output,
                                         FlutterError *_Nullable error) {
                              callback(wrapResult(output, error));
                            }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface MultiFactoResolverHostApiCodecReader : FlutterStandardReader
@end
@implementation MultiFactoResolverHostApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128:
      return [PigeonMultiFactorInfo fromMap:[self readValue]];

    case 129:
      return [PigeonMultiFactorSession fromMap:[self readValue]];

    case 130:
      return [PigeonPhoneMultiFactorAssertion fromMap:[self readValue]];

    default:
      return [super readValueOfType:type];
  }
}
@end

@interface MultiFactoResolverHostApiCodecWriter : FlutterStandardWriter
@end
@implementation MultiFactoResolverHostApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[PigeonMultiFactorInfo class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else if ([value isKindOfClass:[PigeonMultiFactorSession class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else if ([value isKindOfClass:[PigeonPhoneMultiFactorAssertion class]]) {
    [self writeByte:130];
    [self writeValue:[value toMap]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface MultiFactoResolverHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation MultiFactoResolverHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[MultiFactoResolverHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[MultiFactoResolverHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *MultiFactoResolverHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    MultiFactoResolverHostApiCodecReaderWriter *readerWriter =
        [[MultiFactoResolverHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void MultiFactoResolverHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger,
                                    NSObject<MultiFactoResolverHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn"
        binaryMessenger:binaryMessenger
                  codec:MultiFactoResolverHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(resolveSignInResolverId:assertion:completion:)],
                @"MultiFactoResolverHostApi api (%@) doesn't respond to "
                @"@selector(resolveSignInResolverId:assertion:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_resolverId = GetNullableObjectAtIndex(args, 0);
        PigeonPhoneMultiFactorAssertion *arg_assertion = GetNullableObjectAtIndex(args, 1);
        [api resolveSignInResolverId:arg_resolverId
                           assertion:arg_assertion
                          completion:^(NSDictionary<NSString *, id> *_Nullable output,
                                       FlutterError *_Nullable error) {
                            callback(wrapResult(output, error));
                          }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface GenerateInterfacesCodecReader : FlutterStandardReader
@end
@implementation GenerateInterfacesCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128:
      return [PigeonMultiFactorInfo fromMap:[self readValue]];

    default:
      return [super readValueOfType:type];
  }
}
@end

@interface GenerateInterfacesCodecWriter : FlutterStandardWriter
@end
@implementation GenerateInterfacesCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[PigeonMultiFactorInfo class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface GenerateInterfacesCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation GenerateInterfacesCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[GenerateInterfacesCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[GenerateInterfacesCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *GenerateInterfacesGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    GenerateInterfacesCodecReaderWriter *readerWriter =
        [[GenerateInterfacesCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void GenerateInterfacesSetup(id<FlutterBinaryMessenger> binaryMessenger,
                             NSObject<GenerateInterfaces> *api) {
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.GenerateInterfaces.generateInterfaces"
        binaryMessenger:binaryMessenger
                  codec:GenerateInterfacesGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(generateInterfacesInfo:error:)],
                @"GenerateInterfaces api (%@) doesn't respond to "
                @"@selector(generateInterfacesInfo:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonMultiFactorInfo *arg_info = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api generateInterfacesInfo:arg_info error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface MultiFactoResolverHostApiCodecReader : FlutterStandardReader
@end
@implementation MultiFactoResolverHostApiCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [PigeonMultiFactorInfo fromMap:[self readValue]];
    
    case 129:     
      return [PigeonMultiFactorSession fromMap:[self readValue]];
    
    case 130:     
      return [PigeonPhoneMultiFactorAssertion fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface MultiFactoResolverHostApiCodecWriter : FlutterStandardWriter
@end
@implementation MultiFactoResolverHostApiCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[PigeonMultiFactorInfo class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[PigeonMultiFactorSession class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[PigeonPhoneMultiFactorAssertion class]]) {
    [self writeByte:130];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface MultiFactoResolverHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation MultiFactoResolverHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[MultiFactoResolverHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[MultiFactoResolverHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *MultiFactoResolverHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    MultiFactoResolverHostApiCodecReaderWriter *readerWriter = [[MultiFactoResolverHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void MultiFactoResolverHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<MultiFactoResolverHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn"
        binaryMessenger:binaryMessenger
        codec:MultiFactoResolverHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(resolveSignInResolverId:assertion:completion:)], @"MultiFactoResolverHostApi api (%@) doesn't respond to @selector(resolveSignInResolverId:assertion:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_resolverId = GetNullableObjectAtIndex(args, 0);
        PigeonPhoneMultiFactorAssertion *arg_assertion = GetNullableObjectAtIndex(args, 1);
        [api resolveSignInResolverId:arg_resolverId assertion:arg_assertion completion:^(NSDictionary<NSString *, id> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface GenerateInterfacesCodecReader : FlutterStandardReader
@end
@implementation GenerateInterfacesCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [PigeonMultiFactorInfo fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface GenerateInterfacesCodecWriter : FlutterStandardWriter
@end
@implementation GenerateInterfacesCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[PigeonMultiFactorInfo class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface GenerateInterfacesCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation GenerateInterfacesCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[GenerateInterfacesCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[GenerateInterfacesCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *GenerateInterfacesGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    GenerateInterfacesCodecReaderWriter *readerWriter = [[GenerateInterfacesCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void GenerateInterfacesSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<GenerateInterfaces> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.GenerateInterfaces.generateInterfaces"
        binaryMessenger:binaryMessenger
        codec:GenerateInterfacesGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(generateInterfacesInfo:error:)], @"GenerateInterfaces api (%@) doesn't respond to @selector(generateInterfacesInfo:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        PigeonMultiFactorInfo *arg_info = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api generateInterfacesInfo:arg_info error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
