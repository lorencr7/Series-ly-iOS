//
//  CustomCellPerfilSeleccionPeliculasPendientes.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 07/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPerfilSeleccionPeliculasPendientes.h"
#import "PerfilViewControllerIpad.h"
#import "PerfilViewControllerIphone.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "ListadoCapitulosPendientesViewController.h"
#import "User.h"

@implementation CustomCellPerfilSeleccionPeliculasPendientes

-(void) executeAction: (UIViewController *) viewController {
    User * usuario = [User getInstance];
    if ([viewController class] == [PerfilViewControllerIphone class]) {
        PerfilViewControllerIphone * perfilViewControllerIphone = (PerfilViewControllerIphone *) viewController;
        ListadoCapitulosPendientesViewController * listadoCapitulosPendientesViewController = [[ListadoCapitulosPendientesViewController alloc] initWithFrame:perfilViewControllerIphone.view.frame SourceData:SourcePeliculasPendientes];
        listadoCapitulosPendientesViewController.title = @"Películas pendientes";
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UINavigationController * navigationController = [appDelegate.drawerViewController.viewControllers objectAtIndex:1];
        [navigationController pushViewController:listadoCapitulosPendientesViewController animated:YES];
    } else if([viewController class] == [PerfilViewControllerIpad class]) {
        PerfilViewControllerIpad * perfilViewControllerIpad = (PerfilViewControllerIpad *) viewController;
        [perfilViewControllerIpad.listadoCapitulosPendientesViewController fillTableViewFromSource:usuario.peliculasPendientes];
    }
}

@end
