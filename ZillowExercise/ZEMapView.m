//
//  ZEMapView.m
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import "ZEMapView.h"
#import <PureLayout/PureLayout.h>

@interface ZEMapView ()
{
    MKMapView *_mapView;
}
@end

@implementation ZEMapView

- (instancetype)init
{
    if (self = [super init]) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initForAutoLayout];
        [self addSubview:_mapView];
        [_mapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [_mapView setDelegate:self];
    }
}

- (void)canViewUserLocation
{
    if (_mapView && ![_mapView showsUserLocation]) {
        [_mapView setShowsUserLocation:YES];
        [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
}

- (void)updateCurrentLocation:(CLLocation *)currentLocation
{

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
}

@end
