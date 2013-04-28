//
//  CustomCellPerfilSeleccionTVShowsPendientes.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 07/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPerfilSeleccionTVShowsPendientes.h"
#import "PerfilViewControllerIpad.h"  
#import "PerfilViewControllerIphone.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "ListadoCapitulosPendientesViewController.h"
#import "User.h"
#import "VerCapitulosPendientesViewController.h"

@implementation CustomCellPerfilSeleccionTVShowsPendientes

-(void) executeAction: (UIViewController *) viewController {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        VerCapitulosPendientesViewController * verCapitulosPendientesViewController = [[VerCapitulosPendientesViewController alloc] initWithTitle:@"TV Shows pendientes"];
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UINavigationController * navigationController = [appDelegate.drawerViewController.viewControllers objectAtIndex:1];
        [navigationController pushViewController:verCapitulosPendientesViewController animated:YES];
    } else {
        if ([viewController class] == [ListadoCapitulosPendientesViewController class]) {
            User * usuario = [User getInstance];
            PerfilViewControllerIpad * perfilViewControllerIpad = (PerfilViewControllerIpad *) viewController;
            [perfilViewControllerIpad.listadoCapitulosPendientesViewController fillTableViewFromSource:usuario.seriesPendientes];
        }
    }
    /*User * usuario = [User getInstance];
    if ([viewController class] == [PerfilViewControllerIphone class]) {
        PerfilViewControllerIphone * perfilViewControllerIphone = (PerfilViewControllerIphone *) viewController;
        ListadoCapitulosPendientesViewController * listadoCapitulosPendientesViewController = [[ListadoCapitulosPendientesViewController alloc] initWithFrame:perfilViewControllerIphone.view.frame SourceData:SourceTVShowsPendientes];
        listadoCapitulosPendientesViewController.title = @"TV Shows pendientes";
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UINavigationController * navigationController = [appDelegate.drawerViewController.viewControllers objectAtIndex:1];
        [navigationController pushViewController:listadoCapitulosPendientesViewController animated:YES];
    } else if([viewController class] == [PerfilViewControllerIpad class]) {
        PerfilViewControllerIpad * perfilViewControllerIpad = (PerfilViewControllerIpad *) viewController;
        [perfilViewControllerIpad.listadoCapitulosPendientesViewController fillTableViewFromSource:usuario.tvShowsPendientes];
    }*/
}

@end
