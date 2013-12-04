//
//  RefreshableAndDownloadableViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 08/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RefreshableViewController.h"
#import "TVFramework.h"

@interface RefreshableViewController ()

@end

@implementation RefreshableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self iniciarRefreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Refresh", nil)];
    self.refreshControl.tintColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    [self.refreshControl addTarget:self
                            action:@selector(pullToRefreshHandler)
                  forControlEvents:UIControlEventValueChanged];
    self.tableViewController.refreshControl = self.refreshControl;
}

-(void) pullToRefreshHandler {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(refresh) object:nil];
    [thread start];
}

-(void) stopRefreshAnimation {
    [self.refreshControl endRefreshing];
}

-(void) refresh {
    self.lastSourceData = nil;
    self.lastSourceData = self.sourceData;
    self.sourceData = [self getSourceData];
    if ([self hayNuevaInfo]) {
        [self performSelectorOnMainThread:@selector(getSectionsMainThread) withObject:nil waitUntilDone:YES];
    }
    [self performSelectorOnMainThread:@selector(stopRefreshAnimation) withObject:nil waitUntilDone:YES];
}

-(BOOL) hayNuevaInfo {
    if (self.lastSourceData) {
        if (![self.lastSourceData isEqualToArray:self.sourceData]) {
            return YES;
        }
    } else {
        return YES;
    }
    return NO;
}

-(void) cancelThreadsAndRequests {
    [super cancelThreadsAndRequests];
    for (int i = 0; i < self.lastSourceData.count; i++) {
        NSObject * object = self.sourceData[i];
        object = nil;
    }
    self.lastSourceData = nil;
}

@end
