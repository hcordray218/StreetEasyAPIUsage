//
//  ZEMapViewController.h
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZEMapView.h"
#import <CoreLocation/CoreLocation.h>

@interface ZEMapViewController : UIViewController <ZEMapViewDelegate, CLLocationManagerDelegate>

@end
