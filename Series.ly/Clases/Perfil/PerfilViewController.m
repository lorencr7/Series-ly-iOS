//
//  PerfilViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "PerfilViewController.h"
#import "ManejadorServicioWebSeriesLy.h"
#import "User.h"
#import "AvatarViewController.h"

@interface PerfilViewController ()

@end

@implementation PerfilViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) getData {
    ManejadorServicioWebSeriesLy * manejadorServicioWebSeriesLy = [ManejadorServicioWebSeriesLy getInstance];
    self.user = [manejadorServicioWebSeriesLy getUserInfoWithRequest:nil ProgressView:nil];
    
    //NSLog(@"%@",self.user.email);
    
    if (self.user) {
        return YES;
    } else {
        return NO;
    }
    
}

-(void) createData {
    [self createAvatarView];
    [self stopActivityIndicator];
}

-(void) createAvatarView {
    CGRect frame = CGRectMake(0,
                              0,
                              self.view.frame.size.width,
                              120);
    self.avatarViewController = [[AvatarViewController alloc] initWithFrame:frame User:self.user];
    [self addChildViewController:self.avatarViewController];
    [self.view addSubview:self.avatarViewController.view];
}

@end
