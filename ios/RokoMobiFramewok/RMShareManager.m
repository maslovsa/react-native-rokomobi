//
//  RMShareManager.m
//  AwesomeProject
//
//  Created by Maslov Sergey on 06.12.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMShareManager.h"
#import "RCTConvert.h"
#import <ROKOMobi/ROKOMobi.h>
#import <ROKOMobi/ROKOShareViewController.h>
#import "NSDictionary_RMParsing.h"
#import "RMEventEmitter.h"

NSString *const kDisplayMessageKey = @"displayMessage";
NSString *const kContentTitleKey = @"contentTitle";
NSString *const kContentIdKey = @"contentId";
NSString *const kChannelTypeKey = @"channelType";
NSString *const kShareLinkIdKey = @"linkId";
NSString *const kContentURLKey = @"contentURL";

@interface RMShareManager () <ROKOShareDelegate> {
  ROKOShareViewController *shareController;  
}

@end

@implementation RMShareManager

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;


- (NSDictionary *)constantsToExport
{
  return @{ @"ROKOShareChannelTypeUnknown" : @(ROKOShareChannelTypeUnknown),
            @"ROKOShareChannelTypeEmail" : @(ROKOShareChannelTypeEmail),
            @"ROKOShareChannelTypeTwitter" : @(ROKOShareChannelTypeTwitter),
            @"ROKOShareChannelTypeFacebook" : @(ROKOShareChannelTypeFacebook),
            @"ROKOShareChannelTypeMessage" : @(ROKOShareChannelTypeMessage),
            @"ROKOShareChannelTypeCopy" : @(ROKOShareChannelTypeCopy)
            };
};

RCT_EXPORT_METHOD(share:(NSDictionary*)params) {
  if (params) {
    NSString *contentIdString = [params notNullValueForKey: kContentIdKey] ;
    if (contentIdString == nil ) {
      RMEventEmitter *eventEmitter =  [[RMEventEmitter alloc] init];
      eventEmitter.bridge = _bridge;
      [eventEmitter postShareStatus: @{@"error": @"contentId not found"}];
      return;
    }
    
    shareController = [ROKOShareViewController buildControllerWithContentId: contentIdString];
    shareController.shareManager.delegate = self;
    
    if (params[@"text"]) {
      shareController.shareManager.text = params[@"text"];
    }
    
    if (params[kContentTitleKey]) {
      shareController.shareManager.contentTitle = params[kContentTitleKey];
    }
    
    id url = [params notNullValueForKey: kContentURLKey];
    
    if (url && [url isKindOfClass:[NSURL class]]) {
      shareController.shareManager.contentURL = params[kContentURLKey];
    }
    
    if (params[@"ShareChannelTypeFacebook"]) {
      [shareController.shareManager setText:params[@"ShareChannelTypeFacebook"] forShareChannel:ROKOShareChannelTypeFacebook];
    }
    
    if (params[@"ShareChannelTypeTwitter"]) {
      [shareController.shareManager setText:params[@"ShareChannelTypeTwitter"] forShareChannel:ROKOShareChannelTypeTwitter];
    }
    
    if (params[@"ShareChannelTypeMessage"]) {
      [shareController.shareManager setText:params[@"ShareChannelTypeMessage"] forShareChannel:ROKOShareChannelTypeMessage];
    }
    
    if (params[kDisplayMessageKey]) {
      shareController.displayMessage = params[kDisplayMessageKey];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
      UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
      UIViewController *rootViewController = keyWindow.rootViewController;
      [rootViewController presentViewController:shareController animated:YES completion:nil];
    });
  }
}

RCT_EXPORT_METHOD(shareCompleteForChannel:(NSDictionary*)params withCallBack:(RCTResponseSenderBlock)callback) {
  if (params) {
    NSString *contentIdString = params[kContentIdKey];
    ROKOShare *shareManager = [[ROKOShare alloc] init];
    
    if (contentIdString && contentIdString.length > 0) {
      shareManager.contentId = contentIdString;
    } else {
      callback(@[@"contentId field should be not empty", @"Error"]);
      return;
    }
    
    NSNumber *linkId = params[kShareLinkIdKey];
    if (linkId) {
      shareManager.linkId = linkId;
    }
    
    ROKOShareChannelType channelType = ROKOShareChannelTypeUnknown;
    NSString *channelTypeString = params[kChannelTypeKey];
    
    if (channelTypeString) {
      channelType = [self shareChannelType:channelTypeString];
    }
    
    NSError *error = [shareManager shareCompleteForChannel:channelType];
    
    if (error) {
      callback(@[[error description], @"Error"]);
    } else {
      callback(@[[NSNull null], @"Done"]);
    }
  } else {
    callback(@[@"Bad params", @"Error"]);
  }
}

- (void)shareManager:(ROKOShare *)manager didFinishWithActivityType:(ROKOShareChannelType)activityType result:(ROKOSharingResult)result {
  NSString *status = nil;
  switch (result) {
      case ROKOSharingResultDone:
      status = @"Done";
      break;
      
      case ROKOSharingResultCancelled:
      status = @"Canceled";
      break;
      
      case ROKOSharingResultFailed:
      status = @"Failed";
      break;
  }
  
  RMEventEmitter *eventEmitter =  [[RMEventEmitter alloc] init];
  eventEmitter.bridge = _bridge;
  [eventEmitter postShareStatus: @{@"channel": @(activityType), @"status": status}];
}

- (void)shareManager:(ROKOShare *)shareManager willApplyScheme:(ROKOShareScheme *)scheme {
  
}

- (void)shareManager:(ROKOShare *)shareManager willShowSharingMessageComposer:(id)messageComposer forShareChannelType:(ROKOShareChannelType)channelType {
  
}

- (ROKOShareChannelType)shareChannelType:(NSString *)channelType {
  if ([channelType isEqualToString:@"sms"]) {
    return ROKOShareChannelTypeMessage;
  }
  
  if ([channelType isEqualToString:@"twitter"]) {
    return ROKOShareChannelTypeTwitter;
  }
  
  if ([channelType isEqualToString:@"facebook"]) {
    return ROKOShareChannelTypeFacebook;
  }
  
  if ([channelType isEqualToString:@"email"]) {
    return ROKOShareChannelTypeEmail;
  }
  
  if ([channelType isEqualToString:@"copy"]) {
    return ROKOShareChannelTypeCopy;
  }
  
  return ROKOShareChannelTypeUnknown;
}

@end
