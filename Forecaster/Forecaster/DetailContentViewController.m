//
//  DetailContentViewController.m
//  Forecaster
//
//  Created by Donny Davis on 5/9/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "DetailContentViewController.h"

@interface DetailContentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeLabel;

@end

@implementation DetailContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.locationObject) {
        self.cityLabel.text = self.locationObject.city;
        self.imageView.layer.shadowColor = [UIColor grayColor].CGColor;
        self.imageView.layer.shadowOffset = CGSizeMake(5, 7);
        self.imageView.layer.shadowOpacity = 1;
        self.imageView.layer.shadowRadius = 1.0;
        self.imageView.image = [UIImage imageNamed:self.locationObject.image];
        self.summaryLabel.text = self.locationObject.summary;
        NSString *temperatureString = [NSString stringWithFormat:@"%ld℉", [self.locationObject.temperature integerValue]];
        NSString *feelsLikeTemp = [NSString stringWithFormat:@"Feels Like %ld℉", [self.locationObject.apparentTemperature integerValue]];
        self.temperatureLabel.text = temperatureString;
        self.feelsLikeLabel.text = feelsLikeTemp;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
