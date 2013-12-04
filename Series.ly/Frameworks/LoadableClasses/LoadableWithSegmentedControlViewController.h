//
//  LoadableWithSegmentedControlViewController.h
//  Test Loadable Classes
//
//  Created by Lorenzo Villarroel Pérez on 23/06/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"

@interface LoadableWithSegmentedControlViewController : LoadableViewController

@property(strong,nonatomic) UISegmentedControl * segmentedControl;
@property(strong,nonatomic) NSMutableArray * opcionesSegmented;
@property(strong,nonatomic) UIViewController * viewControllerPresented;
@property(strong,nonatomic) NSMutableArray * viewControllers;

-(void) loadSegmentedControl;
-(BOOL) createTabs;

- (IBAction)manejadorSegmented:(UISegmentedControl *) sender;

@end
