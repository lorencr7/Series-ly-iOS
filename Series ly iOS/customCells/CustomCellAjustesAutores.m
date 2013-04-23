//
//  CustomCellAjustesAutores.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 14/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellAjustesAutores.h"
#import "AjustesViewController.h"

@implementation CustomCellAjustesAutores


-(void) executeAction: (UIViewController *) viewController {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([viewController class] == [AjustesViewControllerIphone class]) {
            AjustesViewControllerIphone * ajustesViewController = (AjustesViewControllerIphone *) viewController;
            [ajustesViewController iniciarAutores];
        }
    } else {
        if ([viewController class] == [AjustesViewControllerIpad class]) {
            AjustesViewControllerIpad * ajustesViewController = (AjustesViewControllerIpad *) viewController;
            [ajustesViewController iniciarAutores];
        }
    }
}

@end
