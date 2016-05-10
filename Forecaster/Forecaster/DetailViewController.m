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
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailPageViewController"];
    self.pageViewController.dataSource = self;
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:(64/255.0) green:(123/255.0) blue:(152/255.0) alpha:1.0];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.currentPage = self.currentPageIndex + 1;
    
    DetailContentViewController *startingViewController = [self viewControllerAtIndex:self.currentPageIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

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
