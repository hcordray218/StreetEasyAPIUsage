//
//  ZEMapView.m
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import "ZEMapView.h"
#import <PureLayout/PureLayout.h>
#import <HexColors/HexColor.h>
#import "Colors.h"

@interface ZEMapView ()
{
    MKMapView *_mapView;
    
    UIView *_informationView;
    UILabel *_areaLabel;
    
    UIView *_salesView;
    UIView *_rentalView;
    UILabel *_salesTitleLabel;
    UILabel *_rentalTitleLabel;
    UILabel *_rentalMedianPriceLabel;
    UILabel *_saleMedianPriceLabel;
    
    NSNumberFormatter *_numberFormatter;
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
        [_mapView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_mapView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_mapView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_mapView setDelegate:self];
    }
    
    if (!_informationView) {
        _informationView = [[UIView alloc] initForAutoLayout];
        [self addSubview:_informationView];
        [_informationView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_mapView];
        [_informationView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_informationView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_informationView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_informationView setBackgroundColor:[UIColor colorWithHexString:blueColorHex]];
        
//        [_informationView setBackgroundColor:[UIColor whiteColor]];
    }
    
    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc] initForAutoLayout];
        [_informationView addSubview:_areaLabel];
        [_areaLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_areaLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_areaLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_areaLabel autoSetDimension:ALDimensionHeight toSize:50];
        [_areaLabel setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:18]];
        [_areaLabel setTextAlignment:NSTextAlignmentCenter];
        [_areaLabel setTextColor:[UIColor whiteColor]];

//        [_areaLabel setTextColor:[UIColor colorWithHexString:blueColorHex]];
        
//        UIView *bottomBorder = [[UIView alloc] initForAutoLayout];
//        [_areaLabel addSubview:bottomBorder];
//        [bottomBorder autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//        [bottomBorder autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//        [bottomBorder autoPinEdgeToSuperviewEdge:ALEdgeRight];
//        [bottomBorder autoSetDimension:ALDimensionHeight toSize:1];
//        [bottomBorder setBackgroundColor:[UIColor colorWithHexString:blueColorHex]];
    }
    
    if (!_salesView) {
        _salesView = [[UIView alloc] initForAutoLayout];
        [_informationView addSubview:_salesView];
        [_salesView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_salesView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_salesView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_areaLabel];
        [_salesView autoSetDimension:ALDimensionHeight toSize:100];
        [_salesView setBackgroundColor:[UIColor whiteColor]];
    }
    
    if (!_salesTitleLabel) {
        _salesTitleLabel = [self priceInformationTitleLabelWithName:@"Sales" inView:_salesView];
    }
    
    if (!_saleMedianPriceLabel) {
        _saleMedianPriceLabel = [self priceInformationMedianLabelInView:_salesView];
    }
    
    if (!_rentalView) {
        _rentalView = [[UIView alloc] initForAutoLayout];
        [_informationView addSubview:_rentalView];
        [_rentalView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_rentalView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_rentalView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_areaLabel];
        [_rentalView autoSetDimension:ALDimensionHeight toSize:100];
        [_rentalView setBackgroundColor:[UIColor whiteColor]];
        
        NSArray *saleAndRentalViews = @[_salesView, _rentalView];
        [saleAndRentalViews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0];
    }
    
    if (!_rentalTitleLabel) {
        _rentalTitleLabel = [self priceInformationTitleLabelWithName:@"Rentals" inView:_rentalView];
    }
    
    if (!_rentalMedianPriceLabel) {
        _rentalMedianPriceLabel = [self priceInformationMedianLabelInView:_rentalView];
    }
}

- (UILabel *)priceInformationTitleLabelWithName:(NSString *)name inView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    [view addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [label setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:18]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithHexString:blueColorHex]];
    [label setText:name];
    [label setMinimumScaleFactor:0.75];
    [label setAdjustsFontSizeToFitWidth:YES];
    
    return label;
}

- (UILabel *)priceInformationMedianLabelInView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    [view addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [label setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:16]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithHexString:blueColorHex]];
    [label setMinimumScaleFactor:0.75];
    [label setAdjustsFontSizeToFitWidth:YES];
    
    return label;
}

- (void)canViewUserLocation
{
    if (_mapView && ![_mapView showsUserLocation]) {
        [_mapView setShowsUserLocation:YES];
        [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
}

- (void)updateArea
{
    [_areaLabel setText:[[self.zeMapViewDelegate currentArea] name]];
}

- (void)updatePriceInformation
{
    if (!_numberFormatter) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [_numberFormatter setCurrencyCode:@"USD"];
    }
    
    [_salesTitleLabel setText:[NSString stringWithFormat:@"Sales (%i)", (int)[[self.zeMapViewDelegate saleInformation] listingCount]]];
    [_rentalTitleLabel setText:[NSString stringWithFormat:@"Rentals (%i)", (int)[[self.zeMapViewDelegate rentalInformation] listingCount]]];
    
    if ([[self.zeMapViewDelegate saleInformation] medianPrice]) {
        NSString *saleMedian = [NSString stringWithFormat:@"Median: %@", [_numberFormatter stringFromNumber:[NSNumber numberWithInteger:[[self.zeMapViewDelegate saleInformation] medianPrice]]]];
        [_saleMedianPriceLabel setText:saleMedian];
    }
    else {
        [_saleMedianPriceLabel setText:nil];
    }
    if ([[self.zeMapViewDelegate rentalInformation] medianPrice]) {
        NSString *rentalMedian = [NSString stringWithFormat:@"Median: %@", [_numberFormatter stringFromNumber:[NSNumber numberWithInteger:[[self.zeMapViewDelegate rentalInformation] medianPrice]]]];
        [_rentalMedianPriceLabel setText:rentalMedian];
    }
    else {
        [_rentalMedianPriceLabel setText:nil];
    }
}

@end
