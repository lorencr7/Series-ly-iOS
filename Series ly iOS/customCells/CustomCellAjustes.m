//
//  CustomCellAjustes.m
//  Series ly iOS
//
//  Created by elabi3 on 09/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellAjustes.h"
#import "AjustesViewController.h"
#import "DetailViewController.h"
#import "MasterViewController.h"

@implementation CustomCellAjustes

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        AjustesViewController * ajustesViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            ajustesViewController = [[AjustesViewController alloc] init];
        } else {
            ajustesViewController = [[AjustesViewController alloc] init];
        }
        [detailViewController setDetailItem:ajustesViewController];
    }
}

@end
