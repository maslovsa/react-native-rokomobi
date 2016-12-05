//
//  RMLinkManager.m
//  AwesomeProject
//
//  Created by Maslov Sergey on 02.12.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMLinkManager.h"
#import "RCTConvert.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOLink+ROKOLinkMapper.h"

NSString *const kNameKey = @"name";
NSString *const kTypeKey = @"type";
NSString *const kSourceURLKey = @"sourceURL";
NSString *const kChannelNameKey = @"channelName";
NSString *const kSharingCodeKey = @"sharingCode";
NSString *const kAdvancedSettingsKey = @"advancedSettings";

NSString *const kLinkURLKey = @"linkURL";
NSString *const kLinkIdKey = @"linkId";

@interface RMLinkManager () <ROKOLinkManagerDelegate> {
  ROKOLinkManager *_linkManager;
  RCTResponseSenderBlock _callback;
}

@end

@implementation RMLinkManager

RCT_EXPORT_MODULE();

- (NSDictionary *)constantsToExport
{
  return @{ @"ROKOLinkTypeManual" : @(ROKOLinkTypeManual),
            @"ROKOLinkTypePromo" : @(ROKOLinkTypePromo),
            @"ROKOLinkTypeReferral" : @(ROKOLinkTypeReferral),
            @"ROKOLinkTypeShare" : @(ROKOLinkTypeShare)};
};

RCT_EXPORT_METHOD(handleDeepLink:(NSString*)link withCallBack:(RCTResponseSenderBlock)callback) {
  _linkManager = [[ROKOLinkManager alloc] init];
  if (link) {
    NSURL *nsurl = [[NSURL alloc] initWithString:link];
    _callback = callback;
    
    if (nsurl) {
      _linkManager.delegate = self;
      [_linkManager handleDeepLink:nsurl];
    }
  }
}


RCT_EXPORT_METHOD(createLink:(NSDictionary*)params withCallBack:(RCTResponseSenderBlock)callback) {
  ROKOLinkManager *linkManager = [[ROKOLinkManager alloc] init];
  if (params) {
    [linkManager createLinkWithName:params[kNameKey]
                                type:[params[kTypeKey] intValue]
                           sourceURL:params[kSourceURLKey]
                         channelName:params[kChannelNameKey]
                         sharingCode:params[kSharingCodeKey]
                    advancedSettings:params[kAdvancedSettingsKey]
                     completionBlock:^(NSString *_Nullable linkURL, NSNumber *_Nullable linkId, NSError *_Nullable error) {
                       if (error) {
                         callback(@[error.description, @"Error"]);
                       } else {
                         NSMutableDictionary *dictionary = [NSMutableDictionary new];
                         
                         if (linkURL) {
                           dictionary[kLinkURLKey] = linkURL;
                         }
                         
                         if (linkId) {
                           dictionary[kLinkIdKey] = linkId;
                         }
                         callback(@[[NSNull null], dictionary]);
                       }
                     }];
  }
}

- (void)linkManager:(nonnull ROKOLinkManager *)manager didOpenDeepLink:(nonnull ROKOLink *)link {
  NSDictionary *representation = [EKSerializer serializeObject:link withMapping:[ROKOLink objectMapping]];
  _callback(@[[NSNull null], representation]);
}

- (void)linkManager:(nonnull ROKOLinkManager *)manager didFailToOpenDeepLinkWithError:(nullable NSError *)error {
  _callback(@[error.description, @"Error"]);
}

@end
