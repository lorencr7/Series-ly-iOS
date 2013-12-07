//
//  MasterViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"Series.ly";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    [self setBackgroundColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
