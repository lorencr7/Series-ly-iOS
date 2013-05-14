//
//  CustomCellPerfilListadoCapitulos.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 07/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPerfilListadoCapitulos.h"
#import "VerLinksViewController.h"
#import "ListadoLinksViewController.h"
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

    VerLinksViewController * linksViewController = [[VerLinksViewController alloc] initWithMediaElementUserPending:self.mediaElementUserPending];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [viewController.navigationController pushViewController:linksViewController animated:YES];
    } else {
        //ListadoLinksViewController * listadoLinksViewController = [[ListadoLinksViewController alloc] initWithFrame:linksViewController.view.frame MediaElementUserPending:self.mediaElementUserPending];
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:linksViewController];
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        navigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
        [viewController presentViewController:navigationController animated:YES completion:nil];
    }
}

@end
