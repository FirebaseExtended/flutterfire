// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FirebasePerformancePlugin+Internal.h"

@interface FLTTrace ()
@property FIRTrace *trace;
@end

@implementation FLTTrace
- (instancetype _Nonnull)initWithTrace:(FIRTrace *)trace {
  self = [self init];
  if (self) {
    _trace = trace;
  }

  return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([@"Trace#start" isEqualToString:call.method]) {
    [self start:result];
  } else if ([@"Trace#stop" isEqualToString:call.method]) {
    [self stop:call result:result];
  } else if ([@"Trace#setMetric" isEqualToString:call.method]) {
    [self setMetric:call result:result];
  } else if ([@"Trace#incrementMetric" isEqualToString:call.method]) {
    NSLog(@"incrementing on the native side");
    [self incrementMetric:call result:result];
  } else if ([@"Trace#getMetric" isEqualToString:call.method]) {
    NSLog(@"getting metric on the native side");
    [self getMetric:call result:result];
  } else if ([@"PerformanceAttributes#putAttribute" isEqualToString:call.method]) {
    [self putAttribute:call result:result];
  } else if ([@"PerformanceAttributes#removeAttribute" isEqualToString:call.method]) {
    [self removeAttribute:call result:result];
  } else if ([@"PerformanceAttributes#getAttributes" isEqualToString:call.method]) {
    [self getAttributes:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)start:(FlutterResult)result {
  [_trace start];
  result(nil);
}

- (void)stop:(FlutterMethodCall *)call result:(FlutterResult)result {
  [_trace stop];

  NSNumber *handle = call.arguments[@"handle"];
  [FLTFirebasePerformancePlugin removeMethodHandler:handle];

  result(nil);
}

- (void)setMetric:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *name = call.arguments[@"name"];
  NSNumber *value = call.arguments[@"value"];

  [_trace setIntValue:value.longValue forMetric:name];
  result(nil);
}

- (void)incrementMetric:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *name = call.arguments[@"name"];
  NSNumber *value = call.arguments[@"value"];

  NSLog(@"incrementing on native side with name: %@ and value: %@", name, [value stringValue]);
  [_trace incrementMetric:name byInt:value.longValue];
  result(nil);
}

- (void)getMetric:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *name = call.arguments[@"name"];

  int64_t metric = [_trace valueForIntMetric:name];

  NSLog(@"getting metric native side with name: %@ and value: %d", name, metric);
  result(@(metric));
}

- (void)putAttribute:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *name = call.arguments[@"name"];
  NSString *value = call.arguments[@"value"];

  [_trace setValue:value forAttribute:name];
  result(nil);
}

- (void)removeAttribute:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *name = call.arguments[@"name"];

  [_trace removeAttribute:name];
  result(nil);
}

- (void)getAttributes:(FlutterResult)result {
  result([_trace attributes]);
}
@end
