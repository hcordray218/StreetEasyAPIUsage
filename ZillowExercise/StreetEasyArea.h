//
//  StreetEasyArea.h
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface StreetEasyArea : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger parentId;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *path;

@end
