//
//  AjustesViewControllerIphone.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 20/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "AjustesViewControllerIphone.h"
#import "ScreenSizeManager.h"
#import "AcercaDeViewController.h"

@interface AjustesViewControllerIphone ()

@end

@implementation AjustesViewControllerIphone

- (id)init {
    self = [super init];
    if (self) {
        

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.acercaDeViewController = [[AcercaDeViewController alloc] initWithFrame:self.view.frame];
    self.acercaDeViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.acercaDeViewController.view];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
