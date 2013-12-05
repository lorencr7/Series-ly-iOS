//
//  LoginiPadViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoginiPadViewController.h"
#import "LoginLogoViewController.h"

@interface LoginiPadViewController ()

@end

@implementation LoginiPadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createLoginLogo {
    int margin = 20;
    CGRect frame = CGRectMake(margin,
                              145,
                              self.view.frame.size.width - 2*margin,
                              250);
    self.loginLogoViewController = [[LoginLogoViewController alloc] initWithFrame:frame];
    [self addChildViewController:self.loginLogoViewController];
    [self.scrollView addSubview:self.loginLogoViewController.view];
    
}

-(void) createLoginInput {
    int margin = 20;
    CGRect frame = CGRectMake(margin,
                              self.view.frame.size.height*0.5,
                              self.view.frame.size.width - 2*margin,
                              150);
    self.loginInputViewController = [[LoginInputViewController alloc] initWithFrame:frame];
    self.loginInputViewController.delegate = self;
    [self addChildViewController:self.loginInputViewController];
    [self.scrollView addSubview:self.loginInputViewController.view];
    
}

@end
