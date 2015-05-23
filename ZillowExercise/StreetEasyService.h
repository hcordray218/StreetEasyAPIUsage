//
//  StreetEasyService.h
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "StreetEasyArea.h"

@interface StreetEasyService : NSObject

+ (StreetEasyService *)sharedInstance;

- (void)getAreaForLocation:(CLLocation *)location withCallback:(void (^)(NSError *, StreetEasyArea *))callback;

- (void)getSalesForArea:(StreetEasyArea *)area
               withBeds:(NSInteger)beds
              withBaths:(NSInteger)baths
           withCallback:(void (^)(NSError *, NSArray *))callback;

- (void)getRentalsForArea:(StreetEasyArea *)area
                 withBeds:(NSInteger)beds
                withBaths:(NSInteger)baths
             withCallback:(void (^)(NSError *, NSArray *))callback;

@end
