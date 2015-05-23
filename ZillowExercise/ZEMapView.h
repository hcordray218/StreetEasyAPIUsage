//
//  ZEMapView.h
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "StreetEasyArea.h"
#import "StreetEasyPriceInformation.h"

@protocol ZEMapViewDelegate <NSObject>

- (CLLocation *)currentLocation;

- (StreetEasyArea *)currentArea;
- (StreetEasyPriceInformation *)saleInformation;
- (StreetEasyPriceInformation *)rentalInformation;

@end

@interface ZEMapView : UIView <MKMapViewDelegate>

@property (nonatomic, weak) id<ZEMapViewDelegate>zeMapViewDelegate;

- (void)canViewUserLocation;

- (void)updateArea;

- (void)updatePriceInformation;

@end
