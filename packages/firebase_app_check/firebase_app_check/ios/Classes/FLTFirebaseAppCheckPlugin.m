// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FLTFirebaseAppCheckPlugin.h"

#import <Firebase/Firebase.h>

#import <firebase_core/FLTFirebasePluginRegistry.h>

NSString *const kFLTFirebaseAppCheckChannelName = @"plugins.flutter.io/firebase_app_check";

@interface FLTFirebaseAppCheckPlugin ()
@end

@implementation FLTFirebaseAppCheckPlugin

#pragma mark - FlutterPlugin

// Returns a singleton instance of the Firebase Functions plugin.
+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  static FLTFirebaseAppCheckPlugin *instance;

  dispatch_once(&onceToken, ^{
    instance = [[FLTFirebaseAppCheckPlugin alloc] init];
    // Register with the Flutter Firebase plugin registry.
    [[FLTFirebasePluginRegistry sharedInstance] registerFirebasePlugin:instance];
  });

  return instance;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:kFLTFirebaseAppCheckChannelName
                                  binaryMessenger:[registrar messenger]];
  FLTFirebaseAppCheckPlugin *instance = [FLTFirebaseAppCheckPlugin sharedInstance];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)flutterResult {
  
  FLTFirebaseMethodCallErrorBlock errorBlock = ^(
      NSString *_Nullable code, NSString *_Nullable message, NSDictionary *_Nullable details,
      NSError *_Nullable error) {
    NSMutableDictionary *errorDetails = [NSMutableDictionary dictionary];
    NSString *errorCode = [NSString stringWithFormat:@"%ld", error.code];
    NSString *errorMessage = error.localizedDescription;
    errorDetails[@"code"] = errorCode;
    errorDetails[@"message"] = errorMessage;
    flutterResult([FlutterError errorWithCode:errorCode message:errorMessage details:errorDetails]);
  };

  FLTFirebaseMethodCallResult *methodCallResult =
      [FLTFirebaseMethodCallResult createWithSuccess:flutterResult andErrorBlock:errorBlock];
  // Only a single method implemented.
  if ([@"FirebaseAppCheck#activate" isEqualToString:call.method]) {
    [self activate:call.arguments withMethodCallResult:methodCallResult];
  } else if([@"FirebaseAppCheck#getToken" isEqualToString:call.method]){
    [self getToken:call.arguments withMethodCallResult:methodCallResult];
  } else if([@"FirebaseAppCheck#setTokenAutoRefreshEnabled" isEqualToString:call.method]){
    [self setTokenAutoRefreshEnabled:call.arguments withMethodCallResult:methodCallResult];
  } else {
    flutterResult(FlutterMethodNotImplemented);
  }
}

#pragma mark - Firebase Functions API

- (void)activate:(id)arguments withMethodCallResult:(FLTFirebaseMethodCallResult *)result {
  // TODO the App Check Firebase iOS SDK doesn't allow us to set a provider
  // TODO after Firebase core has been initialized, which means we can't currently
  // TODO support changing providers in FlutterFire. So for now we'll do nothing.

  //  BOOL debug = [arguments[@"debug"] boolValue];
  //  id<FIRAppCheckProviderFactory> provider;
  //  if (debug) {
  //    provider = [FIRAppCheckDebugProviderFactory alloc];
  //  } else {
  //    provider = [FIRDeviceCheckProviderFactory alloc];
  //  }
  //  [FIRAppCheck setAppCheckProviderFactory:provider];
  result.success(nil);
}

- (void) getToken:(id) arguments withMethodCallResult:(FLTFirebaseMethodCallResult *)result {
  FIRAppCheck *appCheck = [self getFIRAppCheckFromArguments:arguments];
  bool forceRefresh = arguments[@"forceRefresh"];
  [appCheck tokenForcingRefresh:forceRefresh completion:^(FIRAppCheckToken * _Nullable token, NSError * _Nullable error) {
    if (error != nil) {
      result.error(nil, nil, nil, error);
    }
    
    NSMutableDictionary *response = [NSMutableDictionary dictionary];
    
    response[@"token"] = token;
    result.success(response);
  }];
}
//setTokenAutoRefreshEnabled

- (void) setTokenAutoRefreshEnabled:(id) arguments withMethodCallResult:(FLTFirebaseMethodCallResult *)result {
  FIRAppCheck *appCheck = [self getFIRAppCheckFromArguments:arguments];
  bool isTokenAutoRefreshEnabled = arguments[@"isTokenAutoRefreshEnabled"];
  appCheck.isTokenAutoRefreshEnabled = isTokenAutoRefreshEnabled;
  result.success(nil);
}

#pragma mark - FLTFirebasePlugin

- (void)didReinitializeFirebaseCore:(void (^)(void))completion {
  completion();
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
  return kFLTFirebaseAppCheckChannelName;
}

#pragma mark - Utilities

- (FIRAppCheck *_Nullable)getFIRAppCheckFromArguments:(NSDictionary *)arguments {
  NSString *appNameDart = arguments[@"appName"];
  FIRApp *app = [FLTFirebasePlugin firebaseAppNamed:appNameDart];
  FIRAppCheck *appCheck = [FIRAppCheck appCheckWithApp:app];

  return appCheck;
}

@end
