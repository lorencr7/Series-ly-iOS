//
//  DetailViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"Detail";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {    
}

@end
