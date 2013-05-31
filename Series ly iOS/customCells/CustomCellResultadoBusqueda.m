//
//  CustomCellResultadoBusqueda.m
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 31/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellResultadoBusqueda.h"
#import "DetailViewController.h"
#import "PerfilViewControllerIpad.h"
#import "PerfilViewControllerIphone.h"

@implementation CustomCellResultadoBusqueda


-(void) executeAction:(UIViewController *)viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        PerfilViewController * perfilViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            perfilViewController = [[PerfilViewControllerIphone alloc] init];
            //perfilViewController = [PerfilViewControllerIphone getInstance];
        } else {
            perfilViewController = [[PerfilViewControllerIpad alloc] init];
            //perfilViewController = [PerfilViewControllerIpad getInstance];
        }
        [detailViewController.navigationController pushViewController:perfilViewController animated:YES];
    }
}

@end
