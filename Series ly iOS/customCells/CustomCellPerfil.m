//
//  CustomCellPerfil.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPerfil.h"
#import "PerfilViewController.h"
#import "DetailViewController.h"
#import "MasterViewController.h"

@implementation CustomCellPerfil

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        PerfilViewControllerIpad * perfilViewControllerIpad = [[PerfilViewControllerIpad alloc] init];
        [detailViewController setDetailItem:perfilViewControllerIpad];
    }
}



@end
