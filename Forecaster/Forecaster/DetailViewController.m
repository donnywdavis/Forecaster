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

@interface DetailViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

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
    self.pageViewController.delegate = self;
    
    self.pageControl.numberOfPages = self.detailItem.count;
    self.pageControl.currentPage = self.currentPageIndex;
    
    DetailContentViewController *startingViewController = [self viewControllerAtIndex:self.currentPageIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.pageControl];
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

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    DetailContentViewController *detailVC = (DetailContentViewController *)pendingViewControllers[0];
    self.pageControl.currentPage = detailVC.pageIndex;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed) {
        DetailContentViewController *detailVC = (DetailContentViewController *)previousViewControllers[0];
        self.pageControl.currentPage = detailVC.pageIndex;
    }
}

- (DetailContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    DetailContentViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailContentViewController"];
    Location *locationObject = self.detailItem[index];
    detailVC.locationObject = locationObject;
    detailVC.pageIndex = index;
    return detailVC;
}


@end
