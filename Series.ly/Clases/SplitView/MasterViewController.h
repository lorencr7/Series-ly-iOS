//
//  MasterViewController.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "RootViewController.h"

@class DetailViewController,MasterTableViewController;
@interface MasterViewController : UIViewController

@property (strong, nonatomic) DetailViewController * detailViewController;

@property (strong, nonatomic) MasterTableViewController * masterTableViewController;

- (id)initWithDetailViewController: (DetailViewController *) detailViewController;


@end
