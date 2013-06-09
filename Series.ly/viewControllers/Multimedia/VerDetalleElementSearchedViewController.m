//
//  VerDetalleElementSearchedViewController.m
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 31/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "VerDetalleElementSearchedViewController.h"

@interface VerDetalleElementSearchedViewController ()

@end

@implementation VerDetalleElementSearchedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
																					target:self
																					action:@selector(handlerAction:)];
	self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handlerAction:(id)sender{
    
    
}

@end
