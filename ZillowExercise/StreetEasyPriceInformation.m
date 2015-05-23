//
//  StreetEasyPriceInformation.m
//  ZillowExercise
//
//  Created by Howard Cordray on 5/23/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import "StreetEasyPriceInformation.h"

@implementation StreetEasyPriceInformation

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"updatedAt": @"updated_at",
             @"listingCount": @"listing_count",
             @"medianPrice": @"median_price",
             @"averagePrice": @"average_price",
             @"criteria": @"criteria",
             @"criteriaDescription": @"criteria_description",
             @"searchUrl": @"search_url",};
}

@end
