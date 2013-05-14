//
//  DetailViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DetailViewController.h"
#import "CustomSplitViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "RootViewController.h"
@interface DetailViewController ()
//@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self removeSubViews];
        // Update the view.
        [self configureView];
    }
    [self.navigationController popToRootViewControllerAnimated:NO];
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [appDelegate.drawerViewController hideDrawer];
        
    } else {
        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            [appDelegate.splitViewController hideMaster];
            //[[CustomSplitViewController getInstance] hideMaster];
        }
    }
}

-(void) removeSubViews {
    UIView * view;
    for (view in self.view.subviews) {
        [view removeFromSuperview];
        view = nil;
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.title = self.detailItem.title;
        [self.view addSubview:self.detailItem.view];
        self.navigationItem.rightBarButtonItem = self.detailItem.navigationItem.rightBarButtonItem;
        [self addChildViewController:self.detailItem];
        //self.detailDescriptionLabel.text = [self.detailItem description];
    }
    /*if (self.detailItem) {
        self.title = self.detailItem.title;
        RootViewController * rootViewController = (RootViewController *) self.detailItem;
        self.view = rootViewController.contenido;
        self.navigationItem.rightBarButtonItem = self.detailItem.navigationItem.rightBarButtonItem;
        
        //self.detailDescriptionLabel.text = [self.detailItem description];
    }*/
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
}

-(void) viewDidAppear:(BOOL)animated {
    //[self.detailItem viewDidAppear:animated];
}

-(void) viewWillAppear:(BOOL)animated {
    //[self.detailItem viewWillAppear:animated];
}

-(void) viewDidDisappear:(BOOL)animated {
    //[self.detailItem viewDidDisappear:animated];
}

-(void) viewWillDisappear:(BOOL)animated {
    //[self.detailItem viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

- (void) showiADBanner {
    int originY;
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        originY = self.view.frame.size.height - 44;
    } else {
        originY = self.view.frame.size.height - 32;
    }
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, originY, 0, 0)];
    self.bannerView.delegate = self;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [self.view addSubview:banner];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"%@",error);
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {

}

@end
