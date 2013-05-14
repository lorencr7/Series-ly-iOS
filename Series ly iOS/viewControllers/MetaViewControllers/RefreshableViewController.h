//
//  RefreshableAndDownloadableViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 08/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"

@class CustomTableViewController;
@interface RefreshableViewController : LoadableViewController

@property (strong, nonatomic) UIRefreshControl *refreshControl;

-(void) iniciarRefreshControl;
-(void) pullToRefreshHandler;
-(void) stopRefreshAnimation;

-(void) refresh;

@end
