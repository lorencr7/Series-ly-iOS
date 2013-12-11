//
//  CustomCellMasterPerfil.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 10/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "CustomCellMasterPerfil.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ContainerPerfiliPadViewController.h"

@implementation CustomCellMasterPerfil


-(void) executeAction:(UIViewController *)viewController {
    ContainerPerfiliPadViewController * containerPerfiliPadViewController = [[ContainerPerfiliPadViewController alloc] init];
    //MasterViewController * master = (MasterViewController *) viewController.parentViewController;
    //[master.detailViewController setDetailItem:containerPerfiliPadViewController];
    DetailViewController * detailViewController = (DetailViewController *) viewController;
    [detailViewController setDetailItem:containerPerfiliPadViewController];
    NSLog(@"hola");
}

@end
