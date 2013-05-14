//
//  RefreshableAndDownloadableViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 08/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DownloadableViewController.h"

@class CustomTableViewController;
@interface RefreshableAndDownloadableViewController : DownloadableViewController

@property (strong, nonatomic) UITableViewController *tableViewController;
@property (strong, nonatomic) CustomTableViewController *customTableView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

-(void) iniciarRefreshControl;
-(void) pullToRefreshHandler;
-(void) stopRefreshAnimation;

@end
