//
//  DetailViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "CustomSplitViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"Detail";
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        if ([_detailItem respondsToSelector:@selector(stopTasks)]) {
            [_detailItem performSelector:@selector(stopTasks)];
        }
        [_detailItem removeFromParentViewController];
        _detailItem = nil;
        _detailItem = newDetailItem;
        [self removeSubViews];
        // Update the view.
        [self configureView];
    }
    [self.navigationController popToRootViewControllerAnimated:NO];
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        [appDelegate.splitViewController hideMaster];
        //[[CustomSplitViewController getInstance] hideMaster];
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
    self.view.backgroundColor = TOPCOLOR;
    //self.view.backgroundColor = [UIColor yellowColor];
    //[self setBackgroundColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
}

@end
