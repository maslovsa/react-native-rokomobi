//
//  NSDictionary+ROKOParsing.m
//  ROKOComponents
//
//  Created by Alexey Golovenkov on 23.04.15.
//  Copyright (c) 2015 ROKOLabs. All rights reserved.
//

#import "NSDictionary_RMParsing.h"

@implementation NSDictionary (ROKOParsing)

- (id)notNullValueForKey:(id<NSCopying>)key {
	id value = self[key];
	if (value == [NSNull null]) {
		return nil;
	}
	return value;
}

@end
