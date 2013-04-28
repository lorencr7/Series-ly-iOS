//
//  CustomCellPerfilListadoCapitulos.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 07/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPerfilListadoCapitulos.h"
#import "LinksViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "CustomSplitViewController.h"
#import "MediaElementUserPending.h"

@implementation CustomCellPerfilListadoCapitulos

- (id)initWithMediaElementUserPending: (MediaElementUserPending *) mediaElementUserPending {
    self = [super init];
    if (self) {
        self.mediaElementUserPending = mediaElementUserPending;
    }
    return self;
}

-(void) executeAction: (UIViewController *) viewController {

    LinksViewController * linksViewController = [[LinksViewController alloc] initWithMediaElementUserPending:self.mediaElementUserPending];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:linksViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UINavigationController * rootNavigationController = [appDelegate.drawerViewController.viewControllers objectAtIndex:1];
        [rootNavigationController pushViewController:linksViewController animated:YES];
        //[appDelegate.drawerViewController presentViewController:navigationController animated:YES completion:nil];
    } else {
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.splitViewController presentViewController:navigationController animated:YES completion:nil];
        //[rootNavigationController pushViewController:linksViewController animated:YES];
        //[viewController presentViewController:navigationController animated:YES completion:nil];
    }
}

@end
