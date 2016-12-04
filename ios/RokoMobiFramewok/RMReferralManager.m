//
//  RMRefferalManager.m
//  AwesomeProject
//
//  Created by Maslov Sergey on 02.12.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMReferralManager.h"
#import "RCTConvert.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOReferralDiscountItem+ROKOReferralDiscountItemMapper.h"
#import "ROKOReferralCampaignInfo+ROKOReferralCampaignInfoMapper.h"

@implementation RMReferralManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(loadReferralDiscountsList:(RCTResponseSenderBlock)callback) {
  ROKOReferral *referral = [[ROKOReferral alloc] init];
  [referral loadReferralDiscountsList:^(NSArray *items, NSError *error) {
    if (error) {
      callback(@[error.description, @"Error"]);
    } else {
      NSMutableArray *referralDiscountItems = [[NSMutableArray alloc] init];
      [referralDiscountItems addObject: [NSNull null]];
      
      for (ROKOReferralDiscountItem *item in items) {
        NSDictionary *representation = [EKSerializer serializeObject:item withMapping:[ROKOReferralDiscountItem objectMapping]];
        [referralDiscountItems addObject:representation];
      }
      
      callback(referralDiscountItems);
    }
  }];
  
}

RCT_EXPORT_METHOD(markReferralDiscountAsUsed:(NSString*)discountId withCallBack:(RCTResponseSenderBlock)callback) {
  NSNumber *discountNumber = @([discountId intValue]);
  
  if (discountNumber) {
    ROKOReferral *referral = [[ROKOReferral alloc] init];
    [referral markReferralDiscountAsUsed:discountNumber completionBlock:^(NSError *error) {
      if (error) {
        callback(@[error.description, @"Error"]);
      } else {
        callback(@[[NSNull null], @"Referral discount has been marked as used. Please refresh view."]);
      }
    }];
  }
}

RCT_EXPORT_METHOD(loadDiscountInfoWithCode:(NSString*)code withCallBack:(RCTResponseSenderBlock)callback) {
  if (code) {
    ROKOReferral *referral = [[ROKOReferral alloc] init];
    [referral loadDiscountInfoWithCode:code completionBlock:^(ROKOReferralCampaignInfo *discount, NSError *error) {
      if (error) {
        callback(@[error.description, @"Error"]);
      } else {
        NSDictionary *representation = [EKSerializer serializeObject:discount withMapping:[ROKOReferralCampaignInfo objectMapping]];
        callback(@[[NSNull null], representation]);
      }
    }];
  }
}

RCT_EXPORT_METHOD(activateDiscountWithCode:(NSString*)code withCallBack:(RCTResponseSenderBlock)callback) {
  if (code) {
    ROKOReferral *referral = [[ROKOReferral alloc] init];
    [referral activateDiscountWithCode:code completionBlock:^(NSNumber *discountId, NSError *error) {
      if (error) {
        callback(@[error.description, @"Error"]);
      } else {
        callback(@[[NSNull null], discountId]);
      }
    }];
  }
}

RCT_EXPORT_METHOD(completeDiscountWithCode:(NSString*)code withCallBack:(RCTResponseSenderBlock)callback) {
  if (code) {    
    ROKOReferral *referral = [[ROKOReferral alloc] init];
    [referral completeDiscountWithCode:code completionBlock:^(NSNumber *discountId, NSNumber *referrerId, NSError *error) {
      if (error) {
        callback(@[error.description, @"Error"]);
      } else {
        NSDictionary *dictionary = @{@"discountId": discountId,
                                     @"referrerId": referrerId};
        callback(@[[NSNull null], dictionary]);
      }
    }];
  }
}

RCT_EXPORT_METHOD(inviteFriends) {
  ROKOInviteFriendsViewController* inviteFriendsController = [ROKOInviteFriendsViewController buildController];
  if (inviteFriendsController) {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *rootViewController = keyWindow.rootViewController;
    [rootViewController presentViewController:inviteFriendsController animated:YES completion:nil];
  }
}

@end


