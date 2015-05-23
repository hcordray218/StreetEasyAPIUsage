//
//  StreetEasyArea.m
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import "StreetEasyArea.h"

@implementation StreetEasyArea

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"level": @"level",
             @"parentId": @"parent_id",
             @"name": @"name",
             @"city": @"city",
             @"state": @"state",
             @"path": @"path",};
}

@end
