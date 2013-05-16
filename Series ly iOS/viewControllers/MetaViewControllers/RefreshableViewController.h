//
//  RefreshableAndDownloadableViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 08/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableWithTableViewController.h"

@class CustomTableViewController;
@interface RefreshableViewController : LoadableWithTableViewController

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) NSMutableArray * lastSourceData;

-(void) iniciarRefreshControl;
-(void) pullToRefreshHandler;
-(void) stopRefreshAnimation;

-(void) refresh;

-(BOOL) hayNuevaInfo;


@end
