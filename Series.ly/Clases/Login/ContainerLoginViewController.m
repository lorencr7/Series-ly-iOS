//
//  ContainerLoginViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "ContainerLoginViewController.h"
#import "LoginiPhoneViewController.h"
#import "LoginiPadViewController.h"

@interface ContainerLoginViewController ()

@end

@implementation ContainerLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"degradado.png"]];
    
    /*CGRect frame = self.view.frame;
     frame.size.height += 20;
     self.view.frame = frame;*/
    [self setBackgroundColor];
    [self createLoginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createLoginView {
    CGRect frame = CGRectMake(0,
                                   0,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.loginViewController = [[LoginiPhoneViewController alloc] initWithFrame:frame];
    } else {
        self.loginViewController = [[LoginiPadViewController alloc] initWithFrame:frame];
    }
    [self addChildViewController:self.loginViewController];
    [self.view addSubview:self.loginViewController.view];
}

-(BOOL) shouldAutorotate {
    return YES;
}

-(NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
