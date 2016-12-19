//
//  RMPortalManager.m
//  MobiTest
//
//  Created by Maslov Sergey on 29.11.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMPortalManager.h"
#import "RCTConvert.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOPortalInfo+ROKOPortalInfoMapper.h"
#import "ROKOSessionInfo+ROKOSessionInfoMapper.h"
#import "ROKOUserObject+ROKOUserObjectMapper.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "RCTEventEmitter.h"
#import "RMEventEmitter.h"

NSString *const kUserNameKey = @"userName";
NSString *const kPasswordKey = @"password";
NSString *const kReferralCodeKey = @"referralCode";
NSString *const kShareChannelKey = @"shareChannel";
NSString *const kEmailKey = @"email";
NSString *const kAmbassadorCodeKey = @"ambassadorCode";
NSString *const kLinkShareChannel = @"linkShareChannel";
NSString *const kNewValueKey = @"propertyValue";
NSString *const kKey = @"propertyName";

@implementation RMPortalManager
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(login:(NSDictionary *)params withCallBack:(RCTResponseSenderBlock)callback) {
  if (params) {
    NSString *userName = params[kUserNameKey];
    NSString *password = params[kPasswordKey];
    
    if (userName && password) {
      ROKOPortalManager *portalManager = [[ROKOComponentManager sharedManager] portalManager];
      [portalManager loginWithUser:userName andPassword:password completionBlock:^(NSError *_Nullable error) {
        if (error) {
          callback(@[error.description, @"Error"]);
        } else {
          callback(@[[NSNull null], @"Login Successful"]);
        }
      }];
    }
  }
}

RCT_EXPORT_METHOD(setUser:(NSDictionary *)params withCallBack:(RCTResponseSenderBlock)callback) {
  if (params) {
    NSString *userName = params[kUserNameKey];
    NSString *referralCode = params[kReferralCodeKey];
    NSString *shareChannel = params[kShareChannelKey];
    
    if (userName) {
      ROKOPortalManager *portalManager = [[ROKOComponentManager sharedManager] portalManager];
      [portalManager setUserWithName:userName referralCode:referralCode linkShareChannel:shareChannel completionBlock:^void (NSError *__nullable error) {
        if (error) {
          callback(@[error.description, @"Error"]);
        } else {
          callback(@[[NSNull null], @"Set User Successful"]);
        }
      }];
    } else {
      callback(@[@"User name not found"]);
    }
  }
}

RCT_EXPORT_METHOD(logout:(RCTResponseSenderBlock)callback) {
  ROKOPortalManager *portalManager = [[ROKOComponentManager sharedManager] portalManager];
  [portalManager logoutWithCompletionBlock:^(NSError *_Nullable error) {
    if (error) {
      callback(@[error.description, @"Error"]);
    } else {
      callback(@[[NSNull null], @"Logout Successful"]);
    }
  }];
}

RCT_EXPORT_METHOD(signupUser:(NSDictionary *)params withCallBack:(RCTResponseSenderBlock)callback) {
  if (params) {
    NSString *userName = params[kUserNameKey];
    NSString *email = params[kEmailKey];
    NSString *password = params[kPasswordKey];
    NSString *ambassadorCode = params[kAmbassadorCodeKey];
    NSString *linkShareChannel = params[kLinkShareChannel];
    if (userName && email && password) {
      ROKOPortalManager *portalManager = [[ROKOComponentManager sharedManager] portalManager];
      [portalManager signupUser:userName email:email andPassword:password ambassadorCode:ambassadorCode linkShareChannel:linkShareChannel completionBlock:^(NSError *_Nullable error) {
        if (error) {
          callback(@[error.description, @"Error"]);
        } else {
          callback(@[[NSNull null], @"Sign up User Successful"]);
        }
      }];
    }
  }
}

RCT_EXPORT_METHOD(getPortalInfo:(RCTResponseSenderBlock)callback) {
  ROKOPortalManager *portalManager = [[ROKOComponentManager sharedManager] portalManager];
  [portalManager getPortalInfoWithCompletionBlock:^(ROKOPortalInfo *_Nullable info, NSError *_Nullable error) {
    if (error) {
      callback(@[error.description, @"Error"]);
    } else {
      NSDictionary *representation = [EKSerializer serializeObject:info withMapping:[ROKOPortalInfo objectMapping]];
      callback(@[[NSNull null], representation]);
    }
  }];
}

RCT_EXPORT_METHOD(getSessionInfo:(RCTResponseSenderBlock)callback) {
  ROKOPortalManager *portalManager = [[ROKOComponentManager sharedManager] portalManager];
  [portalManager getSessionInfoWithCompletionBlock:^(ROKOSessionInfo *_Nullable info, NSError *_Nullable error) {
    if (error) {
      callback(@[error.description, @"Error"]);
    } else {
      NSDictionary *representation = [EKSerializer serializeObject:info withMapping:[ROKOSessionInfo objectMapping]];
      callback(@[[NSNull null], representation]);
    }
  }];
}

RCT_EXPORT_METHOD(getUserInfo:(RCTResponseSenderBlock)callback) { // TODO: remake as property
  ROKOPortalManager *portalManager = [[ROKOComponentManager sharedManager] portalManager];
  ROKOUserObject *userInfo = [portalManager userInfo];

  if (userInfo) {
    NSDictionary *representation = [EKSerializer serializeObject:userInfo withMapping:[ROKOUserObject objectMapping]];
    callback(@[[NSNull null], representation]);
  } else {
    callback(@[[NSNull null], @"No user"]);
  }
}

RCT_EXPORT_METHOD(setUserCustomProperty:(NSDictionary *)params withCallBack:(RCTResponseSenderBlock)callback) {
  if (params) {
    NSString *newValue = params[kNewValueKey];
    NSString *key = params[kKey];
    
    if (key) {
      ROKOPortalManager *portalManager = [[ROKOComponentManager sharedManager] portalManager];
      [portalManager setUserCustomProperty:newValue forKey:key completionBlock:^(NSError * _Nullable error) {
        if (error) {
          callback(@[error.description, @"Error"]);
        } else {
          callback(@[[NSNull null], @"Set User Custom Property Successful"]);
        }
      }];
    } else {
      callback(@[@"Bad Params - propertyName is missed"]);
    }
  }
}

@end
