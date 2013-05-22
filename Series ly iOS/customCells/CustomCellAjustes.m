//
//  CustomCellAjustes.m
//  Series ly iOS
//
//  Created by elabi3 on 09/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellAjustes.h"
#import "AjustesViewController.h"
#import "AjustesViewControllerIpad.h"
#import "AjustesViewControllerIphone.h"
#import "DetailViewController.h"

@implementation CustomCellAjustes

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        AjustesViewController * ajustesViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            ajustesViewController = [[AjustesViewControllerIphone alloc] init];
        } else {
            ajustesViewController = [[AjustesViewControllerIpad alloc] init];
        }
        [detailViewController setDetailItem:ajustesViewController];
    }
}

@end
