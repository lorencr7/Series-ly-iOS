//
//  MasterViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterTableViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithDetailViewController:(DetailViewController *)detailViewController {
    self = [super init];
    if (self) {
        self.detailViewController = detailViewController;
        self.title = @"Series.ly";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    //[self setBackgroundColor];
    self.view.backgroundColor = BOTTOMCOLOR;

    [self createMasterView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createMasterView {
    NSLog(@"%.2f",self.view.frame.size.height/2);
    CGRect frame = CGRectMake(0,
                              0,
                              self.view.frame.size.width,
                              self.view.frame.size.height);
    self.masterTableViewController = [[MasterTableViewController alloc] initWithFrame:frame DetailViewController:self.detailViewController];

    [self addChildViewController:self.masterTableViewController];
    [self.view addSubview:self.masterTableViewController.view];
}

@end
