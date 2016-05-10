//
//  DetailViewController.m
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailContentViewController.h"
#import "MasterViewController.h"
#import "Location.h"

@interface DetailViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSArray *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
//        [self configureView];
    }
}

//- (void)configureView {
//    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        
//        NSString *temperatureString = [NSString stringWithFormat:@"%ld℉", [self.detailItem.temperature integerValue]];
//        NSString *feelsLikeTemp = [NSString stringWithFormat:@"Feels Like %ld℉", [self.detailItem.apparentTemperature integerValue]];
//        
//        self.title = self.detailItem.city;
//        self.weatherLabel.text = self.detailItem.summary;
//        self.temperatureLabel.text = temperatureString;
//        self.feelsLikeTempLabel.text = feelsLikeTemp;
//        if (![self.detailItem.image isEqualToString:@""]){
//            self.weatherImage.image = [UIImage imageNamed:self.detailItem.image];
//            
//        }
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailPageViewController"];
    self.pageViewController.dataSource = self;
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    DetailContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];


//    self.currentLabel.text =@"CURRENTLY";
    
    // Do any additional setup after loading the view, typically from a nib.
//    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((DetailContentViewController *) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index -= 1;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((DetailContentViewController *) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    
    index += 1;
    if (index == self.detailItem.count) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.detailItem.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (DetailContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    DetailContentViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailContentViewController"];
    Location *locationObject = self.detailItem[index];
    detailVC.locationObject = locationObject;
    detailVC.pageIndex = index;
    return detailVC;
}


@end
