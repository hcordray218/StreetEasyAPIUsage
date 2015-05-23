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
    StreetEasyPriceInformation *_saleInformation;
    StreetEasyPriceInformation *_rentalInformation;
    
    ZEMapView *_zeMapView;
    
    UIAlertController *_alertController;
}
@end

@implementation ZEMapViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self setupServices];
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

    [self setupAlertController];
    [self setupLocationManager];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
        if ([_alertController presentingViewController]) {
            [_alertController dismissViewControllerAnimated:YES completion:nil];
        }
        [_zeMapView canViewUserLocation];
    }
    else {
        if (![_alertController presentingViewController]) {
            [self presentViewController:_alertController animated:YES completion:nil];
        }
    }
}

- (void)setupAlertController
{
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                                 message:@"We need your location!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *goToSettings = [UIAlertAction actionWithTitle:@"Go to Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }];
        [_alertController addAction:goToSettings];
    }
}

- (void)getCurrentAreaWithCurrentLocation
{
    if (_currentLocation) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [_streetEasyService getAreaForLocation:_currentLocation
                                  withCallback:^(NSError *error, StreetEasyArea *area) {
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                      if (error) {
                                          
                                      }
                                      else if (area) {
                                          _currentArea = area;
                                          [_zeMapView updateArea];
                                          
                                          [self getSaleInformationWithCurrentArea];
                                          [self getRentalInformationWithCurrentArea];
                                      }
                                  }];
    }
}

- (void)getSaleInformationWithCurrentArea
{
    if (_currentArea) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [_streetEasyService getSaleInformationForArea:_currentArea
                                             withBeds:0
                                            withBaths:0
                                         withCallback:^(NSError *error, StreetEasyPriceInformation *saleInformation) {
                                             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                             if (error) {
                                                 
                                             }
                                             else if (saleInformation) {
                                                 _saleInformation = saleInformation;
                                                 [_zeMapView updatePriceInformation];
                                             }
                                         }];
    }
}

- (void)getRentalInformationWithCurrentArea
{
    if (_currentArea) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [_streetEasyService getRentalInformationForArea:_currentArea
                                               withBeds:0
                                              withBaths:0
                                           withCallback:^(NSError *error, StreetEasyPriceInformation *rentalInformation) {
                                               [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                               if (error) {
                                                   
                                               }
                                               else if (rentalInformation) {
                                                   _rentalInformation = rentalInformation;
                                                   [_zeMapView updatePriceInformation];
                                               }
                                           }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    if (([location distanceFromLocation:_currentLocation] > 250) || !_currentLocation) {
        _currentLocation = [locations lastObject];
        [self getCurrentAreaWithCurrentLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            [_zeMapView canViewUserLocation];
            break;
        }
            
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        {
            if (!_alertController) {
                [self setupAlertController];
            }
            if (![_alertController presentingViewController]) {
                [self presentViewController:_alertController animated:YES completion:nil];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (!_alertController) {
        [self setupAlertController];
    }
    
    if (![_alertController presentingViewController]) {
        [self presentViewController:_alertController animated:YES completion:nil];
    }
}

- (CLLocation *)currentLocation
{
    return _currentLocation;
}

- (StreetEasyArea *)currentArea
{
    return _currentArea;
}

- (StreetEasyPriceInformation *)saleInformation
{
    return _saleInformation;
}

- (StreetEasyPriceInformation *)rentalInformation
{
    return _rentalInformation;
}

@end
