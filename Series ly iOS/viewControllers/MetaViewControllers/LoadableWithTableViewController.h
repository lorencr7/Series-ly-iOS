//
//  LoadableViewController.h
//  FI UPM
//
//  Created by Lorenzo Villarroel on 14/05/13.
//  Copyright (c) 2013 Laboratorio Ingeniería del Software. All rights reserved.
//

#import "LoadableViewController.h"

@class CustomTableViewController;
@interface LoadableWithTableViewController : LoadableViewController 

@property (strong, nonatomic) CustomTableViewController *customTableView;
@property (strong, nonatomic) UITableViewController *tableViewController;



-(void) reloadTableViewWithSections: (NSMutableArray *) sections;

@end
