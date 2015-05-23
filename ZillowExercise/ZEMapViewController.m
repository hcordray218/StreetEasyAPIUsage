//
//  ZEMapViewController.m
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import "ZEMapViewController.h"
#import "StreetEasyService.h"

@interface ZEMapViewController ()
{
    CLLocationManager *_locationManager;
    CLLocation *_currentLocation;
    
    StreetEasyService *_streetEasyService;
    
    StreetEasyArea *_currentArea;
    
    ZEMapView *_zeMapView;
}
@end

@implementation ZEMapViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self setupServices];
        [self setupLocationManager];
    }
    return self;
}

- (void)setupServices
{
    _streetEasyService = [StreetEasyService sharedInstance];
}

- (void)setupLocationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setDistanceFilter:kCLDistanceFilterNone];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
            [_zeMapView canViewUserLocation];
        }
    }
}

- (void)loadView
{
    _zeMapView = [[ZEMapView alloc] init];
    [_zeMapView setZeMapViewDelegate:self];
    [self setView:_zeMapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"StreetEasy"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    if (([location distanceFromLocation:_currentLocation] > 250) || !_currentLocation) {
        _currentLocation = [locations lastObject];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [_streetEasyService getAreaForLocation:_currentLocation
                                  withCallback:^(NSError *error, StreetEasyArea *area) {
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                      if (error) {
                                          
                                      }
                                      else if (area) {
                                          _currentArea = area;
                                      }
                                  }];
    }
}

- (CLLocation *)currentLocation
{
    return _currentLocation;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [_zeMapView canViewUserLocation];
            break;
            
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
            break;
            
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

@end
