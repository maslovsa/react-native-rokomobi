//
//  NSDictionary_RMParsing.h
//  AwesomeProject
//
//  Created by Maslov Sergey on 06.12.16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (RMParsing)

- (id)notNullValueForKey:(id<NSCopying>)key;

@end
