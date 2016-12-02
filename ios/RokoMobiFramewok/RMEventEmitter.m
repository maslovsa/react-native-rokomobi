//
//  RMEventEmitter.m
//  AwesomeProject
//
//  Created by Maslov Sergey on 02.12.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMEventEmitter.h"

@implementation RMEventEmitter

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"RMEventEmitter"];
}

//- (void)sendEventWithName:(NSString *)eventName body:(NSDictionary*)body {
//  [self sendEventWithName:eventName body: body];
//}

@end
