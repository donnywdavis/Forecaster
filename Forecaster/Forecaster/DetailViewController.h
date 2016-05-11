//
//  DetailViewController.h
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSArray *detailItem;
@property NSInteger currentPageIndex;

@end

