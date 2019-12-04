#import "FirebaseMlVisionPlugin.h"

@import FirebaseMLCommon;

@interface LocalVisionEdgeDetector ()
@property FIRVisionImageLabeler *labeler;
@end

@implementation LocalVisionEdgeDetector

- (instancetype)initWithVision:(FIRVision *)vision options:(NSDictionary *)options {
  self = [super init];
  if (self) {
    FIRLocalModel *localModel =
    [[FIRModelManager modelManager] localModelWithName:options[@"dataset"]];
    if (localModel == nil) {
      NSString *pathStart = @"Frameworks/App.framework/flutter_assets/assets/";
      NSString *datasetAppended = [pathStart stringByAppendingString:options[@"dataset"]];
      NSString *finalPath = [datasetAppended stringByAppendingString:@"/manifest.json"];
      NSString *manifestPath = [[NSBundle mainBundle] pathForResource:finalPath ofType:nil];
      FIRLocalModel *localModel = [[FIRLocalModel alloc] initWithName:options[@"dataset"]
                                                                 path:manifestPath];
      [[FIRModelManager modelManager] registerLocalModel:localModel];
      _labeler = [[FIRVision vision]
                  onDeviceAutoMLImageLabelerWithOptions:[LocalVisionEdgeDetector parseOptions:options]];
    } else {
      _labeler = [[FIRVision vision]
                  onDeviceAutoMLImageLabelerWithOptions:[LocalVisionEdgeDetector parseOptions:options]];
    }
  }
  return self;
}

+ (FIRVisionOnDeviceAutoMLImageLabelerOptions *)parseOptions:(NSDictionary *)optionsData {
  NSNumber *conf = optionsData[@"confidenceThreshold"];
  NSString *dataset = optionsData[@"dataset"];

  FIRVisionOnDeviceAutoMLImageLabelerOptions *options =
  [[FIRVisionOnDeviceAutoMLImageLabelerOptions alloc] initWithRemoteModelName:nil
                                                               localModelName:dataset];
  options.confidenceThreshold = [conf floatValue];

  return options;
}

@end
