//
//  RMPromoManager.m
//  AwesomeProject
//
//  Created by Maslov Sergey on 02.12.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RMPromoManager.h"
#import "RCTConvert.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOPromoDiscountItem+ROKOPromoDiscountItemMapper.h"

NSString *const kPromoCodeKey = @"promoCode";
NSString *const kValueOfPurchaseKey = @"valueOfPurchase";
NSString *const kValueOfDiscountKey = @"valueOfDiscount";
NSString *const kDeliveryTypeKey = @"deliveryType";

@implementation RMPromoManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(loadPromo:(NSString*)promoCode withCallBack:(RCTResponseSenderBlock)callback) {
  if (promoCode) {
    NSLog(@"load Promocode - %@", promoCode);
    ROKOPromo *promo = [[ROKOPromo alloc] init];
    [promo loadPromoDiscountWithPromoCode:promoCode completionBlock:^(ROKOPromoDiscountItem *discount, NSError *error) {
      if (error) {
        callback(@[error.description, @"Error"]);
      } else {
        NSDictionary *representation = [EKSerializer serializeObject:discount withMapping:[ROKOPromoDiscountItem objectMapping]];
        callback(@[[NSNull null], representation]);
      }
    }];
  }
}

RCT_EXPORT_METHOD(markPromoCodeAsUsed:(NSDictionary*)params withCallBack:(RCTResponseSenderBlock)callback) {
  if (params) {
    NSString *promoCode = params[kPromoCodeKey];
    NSNumber *valueOfPurchase = params[kValueOfPurchaseKey];
    NSNumber *valueOfDiscount = params[kValueOfDiscountKey];
    NSNumber *deliveryType = params[kDeliveryTypeKey];
    
    ROKOPromo *promo = [[ROKOPromo alloc] init];
    if (promoCode) {
      [promo markPromoCodeAsUsed:promoCode valueOfPurchase:valueOfPurchase valueOfDiscount:valueOfDiscount deliveryType:[deliveryType intValue] completionBlock:^(NSError *error) {
        if (error) {
          callback(@[error.description, @"Error"]);
        } else {
          callback(@[[NSNull null], @"Ok"]);
        }
      }];
    }
  }
}

@end
