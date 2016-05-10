//
//  DetailContentViewController.h
//  Forecaster
//
//  Created by Donny Davis on 5/9/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeLabel;
@property NSUInteger pageIndex;

@end
