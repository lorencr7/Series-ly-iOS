//
//  RefreshableAndDownloadableViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 08/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RefreshableViewController.h"

@interface RefreshableViewController ()

@end

@implementation RefreshableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self iniciarRefreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarRefreshControl {
    //self.tableViewController = [[UITableViewController alloc] init];
    //self.tableViewController.tableView = (UITableView *)self.customTableView;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Actualizar"];
    self.refreshControl.tintColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    [self.refreshControl addTarget:self
                            action:@selector(pullToRefreshHandler)
                  forControlEvents:UIControlEventValueChanged];
     self.tableViewController.refreshControl = self.refreshControl;
}

-(void) pullToRefreshHandler {
    [self performSelectorInBackground:@selector(refresh) withObject:nil];
}

-(void) stopRefreshAnimation {
    [self.refreshControl endRefreshing];
}

-(void) refresh {
    
}

@end