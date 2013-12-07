//
//  ContainerPerfiliPhoneViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "ContainerPerfiliPhoneViewController.h"
#import "AvatarViewController.h"

@interface ContainerPerfiliPhoneViewController ()

@end

@implementation ContainerPerfiliPhoneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAvatarView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createAvatarView {
    CGRect frame = CGRectMake(0,
                              0,
                              self.view.frame.size.width,
                              120);
    self.avatarViewController = [[AvatarViewController alloc] initWithFrame:frame];
    [self addChildViewController:self.avatarViewController];
    [self.view addSubview:self.avatarViewController.view];
}


@end
