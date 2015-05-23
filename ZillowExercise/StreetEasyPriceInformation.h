//
//  StreetEasyPriceInformation.h
//  ZillowExercise
//
//  Created by Howard Cordray on 5/23/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface StreetEasyPriceInformation : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *criteria;
@property (nonatomic, strong) NSString *criteriaDescription;
@property (nonatomic, strong) NSString *searchUrl;

@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic) NSInteger listingCount;

@property (nonatomic) NSInteger medianPrice;
@property (nonatomic) NSInteger averagePrice;

@end
