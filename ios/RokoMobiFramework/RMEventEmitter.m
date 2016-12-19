//
//  RMEventEmitter.m
//  AwesomeProject
//
//  Created by Maslov Sergey on 02.12.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMEventEmitter.h"

NSString *const kPushNotication = @"PushNotication";
NSString *const kDeepLink = @"DeepLink";
NSString *const kShareStatus = @"ShareStatus";

@implementation RMEventEmitter

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
  return @[kPushNotication,kDeepLink, kShareStatus];
}

RCT_EXPORT_METHOD(startListening){
  NSLog(@"RMEventEmitter - startListening");
}

- (void)handleNotification:(NSDictionary*)userInfo {
  [self sendEventWithName: kPushNotication body: userInfo];
}

- (void)handleDeepLink:(NSDictionary*)userInfo {
  [self sendEventWithName: kDeepLink body: userInfo];
}

- (void)postShareStatus:(NSDictionary*)userInfo {
  [self sendEventWithName: kShareStatus body: userInfo];
}

- (void)sendEventWithName:(NSString *)eventName body:(id)body {
  [self.bridge enqueueJSCall:@"RCTDeviceEventEmitter"
                      method:@"emit"
                        args:body ? @[eventName, body] : @[eventName]
                  completion:NULL];
}

@end
