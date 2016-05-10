//
//  DetailContentViewController.h
//  Forecaster
//
//  Created by Donny Davis on 5/9/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface DetailContentViewController : UIViewController

@property Location *locationObject;
@property NSUInteger pageIndex;

@end
