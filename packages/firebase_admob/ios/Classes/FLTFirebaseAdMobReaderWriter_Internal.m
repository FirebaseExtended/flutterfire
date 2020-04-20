#import "FLTFirebaseAdMobReaderWriter_Internal.h"

typedef NS_ENUM(NSInteger, FirebaseAdMobField) {
  FirebaseAdMobFieldAdRequest = 128,
  FirebaseAdMobFieldAdSize = 129,
  FirebaseAdMobFieldAnchorType = 130,
};

@interface FLTFirebaseAdMobReader : FlutterStandardReader
@end

@implementation FLTFirebaseAdMobReaderWriter
- (FlutterStandardReader *_Nonnull)readerWithData:(NSData *_Nonnull)data {
  return [[FLTFirebaseAdMobReader alloc] initWithData:data];
}
@end

@implementation FLTFirebaseAdMobReader
- (id _Nullable)readValueOfType:(UInt8)type {
  FirebaseAdMobField field = (FirebaseAdMobField)type;
  switch (field) {
    case FirebaseAdMobFieldAdRequest:
      return [[FLTAdRequest alloc] init];
    case FirebaseAdMobFieldAdSize:
      return [[FLTAdSize alloc] initWithWidth:[self readValueOfType:[self readByte]]
                                       height:[self readValueOfType:[self readByte]]];
    case FirebaseAdMobFieldAnchorType:
      return [self readValueOfType:[self readByte]];
  }
  return [super readValueOfType:type];
}
@end
