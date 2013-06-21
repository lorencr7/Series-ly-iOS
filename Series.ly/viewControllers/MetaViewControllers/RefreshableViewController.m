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
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(refresh) object:nil];
    [thread start];
    //[self.threads addObject:thread];
    //[self performSelectorInBackground:@selector(refresh) withObject:nil];
}

-(void) stopRefreshAnimation {
    [self.refreshControl endRefreshing];
}

-(void) refresh {
    [self.threads addObject:[NSThread currentThread]];
    self.lastSourceData = self.sourceData;
    self.sourceData = [self getSourceData];
    if ([self hayNuevaInfo]) {
        [self performSelectorOnMainThread:@selector(getSectionsMainThread) withObject:nil waitUntilDone:YES];
        //NSMutableArray * sections = [self getSectionsFromSourceData:self.sourceData];
        //[self performSelectorOnMainThread:@selector(reloadTableViewWithSections:) withObject:sections waitUntilDone:YES];

    }
    [self performSelectorOnMainThread:@selector(stopRefreshAnimation) withObject:nil waitUntilDone:YES];
    [self.threads removeObject:[NSThread currentThread]];
}

/*-(NSMutableArray *) getSourceData {
    return nil;
}

-(NSMutableArray *) getSectionsFromSourceData {
    return nil;
}*/

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

@end