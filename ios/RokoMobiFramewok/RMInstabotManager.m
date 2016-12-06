//
//  RMInstabotManager.m
//  AwesomeProject
//
//  Created by Maslov Sergey on 06.12.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMInstabotManager.h"
#import <ROKOMobi/ROKOMobi.h>

@implementation RMInstabotManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(loadConversationWithId:(nonnull NSNumber*)conversationWithId withCallBack:(RCTResponseSenderBlock)callback) {
  if (conversationWithId) {
    ROKOInstaBot *bot = [[ROKOInstaBot alloc] init];
    [bot loadConversationWithId: [conversationWithId integerValue] completionBlock:^(ROKOInstaBotViewController * _Nullable controller, NSError * _Nullable error) {
      if (error) {
        callback(@[[error description], @"Error"]);
      } else {
        dispatch_async(dispatch_get_main_queue(), ^{
          UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
          UIViewController *rootViewController = keyWindow.rootViewController;
          [rootViewController presentViewController:controller animated:YES completion:nil];
        });
      }
    }];
  }
}

@end
