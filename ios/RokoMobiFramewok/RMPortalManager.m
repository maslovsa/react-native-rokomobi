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
//#import "ROKOPortalInfo+ROKOPortalInfoMapper.h"
//#import "ROKOSessionInfo+ROKOSessionInfoMapper.h"
//#import "ROKOUserObject+ROKOUserObjectMapper.h"

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

RCT_EXPORT_MODULE();

//- (void)pluginInitialize {
//  [super pluginInitialize];
//  _portalManager = [[ROKOComponentManager sharedManager] portalManager];
//}

//- (void)login:(CDVInvokedUrlCommand *)command {
//  [self parseCommand:command];
//  NSDictionary *params = command.arguments[0];
//
//  if (params) {
//    __weak __typeof__(self) weakSelf = self;
//
//    NSString *userName = params[kUserNameKey];
//    NSString *password = params[kPasswordKey];
//
//    if (userName && password) {
//      [_portalManager loginWithUser:userName andPassword:password completionBlock:^(NSError *_Nullable error) {
//        if (error) {
//          [weakSelf handleError:error];
//        } else {
//          CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Login Successful"];
//          [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
//        }
//      }];
//    }
//  }
//}

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

//- (void)logout:(CDVInvokedUrlCommand *)command {
//  [self parseCommand:command];
//  __weak __typeof__(self) weakSelf = self;
//
//  [_portalManager logoutWithCompletionBlock:^(NSError *_Nullable error) {
//    if (error) {
//      [weakSelf handleError:error];
//    } else {
//      CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Logout Successful"];
//      [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
//    }
//  }];
//
//}
//
//- (void)signupUser:(CDVInvokedUrlCommand *)command {
//  [self parseCommand:command];
//  NSDictionary *params = command.arguments[0];
//
//  if (params) {
//    __weak __typeof__(self) weakSelf = self;
//
//    NSString *userName = params[kUserNameKey];
//    NSString *email = params[kEmailKey];
//    NSString *password = params[kPasswordKey];
//    NSString *ambassadorCode = params[kAmbassadorCodeKey];
//    NSString *linkShareChannel = params[kLinkShareChannel];
//
//    if (userName && email && password) {
//      [_portalManager signupUser:userName email:email andPassword:password ambassadorCode:ambassadorCode linkShareChannel:linkShareChannel completionBlock:^(NSError *_Nullable error) {
//        if (error) {
//          [weakSelf handleError:error];
//        } else {
//          CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Sign up User Successful"];
//          [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
//        }
//      }];
//    }
//  }
//
//}
//
//- (void)getPortalInfo:(CDVInvokedUrlCommand *)command {
//  [self parseCommand:command];
//  __weak __typeof__(self) weakSelf = self;
//
//  [_portalManager getPortalInfoWithCompletionBlock:^(ROKOPortalInfo *_Nullable info, NSError *_Nullable error) {
//    if (error) {
//      [weakSelf handleError:error];
//    } else {
//      NSDictionary *representation = [EKSerializer serializeObject:info withMapping:[ROKOPortalInfo objectMapping]];
//      CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
//      [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
//
//    }
//  }];
//}
//
//- (void)getSessionInfo:(CDVInvokedUrlCommand *)command {
//  [self parseCommand:command];
//  __weak __typeof__(self) weakSelf = self;
//
//  [_portalManager getSessionInfoWithCompletionBlock:^(ROKOSessionInfo *_Nullable info, NSError *_Nullable error) {
//    if (error) {
//      [weakSelf handleError:error];
//    } else {
//      NSDictionary *representation = [EKSerializer serializeObject:info withMapping:[ROKOSessionInfo objectMapping]];
//      CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
//      [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
//
//    }
//  }];
//
//}
//
//- (void)getUserInfo:(CDVInvokedUrlCommand *)command {
//  [self parseCommand:command];
//  ROKOUserObject *userInfo = [_portalManager userInfo];
//
//  if (userInfo) {
//    NSDictionary *representation = [EKSerializer serializeObject:userInfo withMapping:[ROKOUserObject objectMapping]];
//    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
//    [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
//  } else {
//    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"No user"];
//    [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
//  }
//}

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
