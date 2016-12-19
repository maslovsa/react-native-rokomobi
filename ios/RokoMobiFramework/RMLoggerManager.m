//
//  RMLoggerManager.m
//  AwesomeProject
//
//  Created by Maslov Sergey on 28.11.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMLoggerManager.h"
#import "RCTConvert.h"
#import <ROKOMobi/ROKOMobi.h>

@implementation RMLoggerManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(addEvent:(NSDictionary *)params)
{
  NSLog(@"%@", ROKOComponentManager.sharedManager.apiToken);

  if (params && params[@"name"]) {
    NSString *eventName = params[@"name"];
    NSDictionary *parameters = params[@"params"];
    [ROKOLogger addEvent:eventName withParameters: parameters];
  }
  
}
@end
