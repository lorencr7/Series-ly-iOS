//
//  CustomCellPerfilSeleccionSeriesPendientes.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 07/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPerfilSeleccionSeriesPendientes.h"
#import "PerfilViewControllerIpad.h"
#import "PerfilViewControllerIphone.h"
#import "ListadoCapitulosPendientesViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "VerCapitulosPendientesViewController.h"

@implementation CustomCellPerfilSeleccionSeriesPendientes

-(void) executeAction: (UIViewController *) viewController {
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        VerCapitulosPendientesViewController * verCapitulosPendientesViewController = [[VerCapitulosPendientesViewController alloc] initWithTitle:@"Capítulos pendientes" SourceData:SourceSeriesPendientes];
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UINavigationController * navigationController = [appDelegate.drawerViewController.viewControllers objectAtIndex:1];
        [navigationController pushViewController:verCapitulosPendientesViewController animated:YES];
    } else {
        User * usuario = [User getInstance];
        ListadoCapitulosPendientesViewController * listadoCapitulosPendientesViewController = (ListadoCapitulosPendientesViewController*) viewController;
        [listadoCapitulosPendientesViewController fillTableViewFromSource:usuario.seriesPendientes];
    }
    
    
    
    
    /*if ([viewController class] == [PerfilViewControllerIphone class]) {
     PerfilViewControllerIphone * perfilViewControllerIphone = (PerfilViewControllerIphone *) viewController;
     ListadoCapitulosPendientesViewController * listadoCapitulosPendientesViewController = [[ListadoCapitulosPendientesViewController alloc] initWithFrame:perfilViewControllerIphone.view.frame SourceData:SourceSeriesPendientes];
     listadoCapitulosPendientesViewController.title = @"Capítulos pendientes";
     AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     UINavigationController * navigationController = [appDelegate.drawerViewController.viewControllers objectAtIndex:1];
     [navigationController pushViewController:listadoCapitulosPendientesViewController animated:YES];
     } else if([viewController class] == [PerfilViewControllerIpad class]) {
     PerfilViewControllerIpad * perfilViewControllerIpad = (PerfilViewControllerIpad *) viewController;
     [perfilViewControllerIpad.listadoCapitulosPendientesViewController fillTableViewFromSource:usuario.seriesPendientes];
     }*/
}

@end
