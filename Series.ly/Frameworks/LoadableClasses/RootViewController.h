//
//  RootViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ParentViewController.h"
@interface RootViewController : ParentViewController

@property (strong, nonatomic) CAGradientLayer *gradient;

@property (strong, nonatomic) UIBarButtonItem * backButton;

-(void) stopTasks;

-(void) handlerBackButtonNavigationBar;

-(void) setBackgroundColor;


@end
