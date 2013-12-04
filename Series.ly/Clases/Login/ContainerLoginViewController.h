//
//  ContainerLoginViewController.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "RootViewController.h"

@class LoginViewController;
@interface ContainerLoginViewController : RootViewController

@property(strong, nonatomic) LoginViewController * loginViewController;

@end
