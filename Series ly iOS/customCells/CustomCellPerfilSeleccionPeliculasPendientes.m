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
#import "ListadoCapitulosPendientesViewController.h"
#import "ListadoOpcionesPerfilViewController.h"
#import "User.h"
#import "VerCapitulosPendientesViewController.h"

@implementation CustomCellPerfilSeleccionPeliculasPendientes

-(void) executeAction: (UIViewController *) viewController {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        VerCapitulosPendientesViewController * verCapitulosPendientesViewController = [[VerCapitulosPendientesViewController alloc] initWithTitle:@"Películas pendientes" SourceData:SourcePeliculasPendientes];
        [viewController.navigationController pushViewController:verCapitulosPendientesViewController animated:YES];
    } else {
        User * usuario = [User getInstance];
        ListadoOpcionesPerfilViewController * listadoOpcionesPerfilViewController = (ListadoOpcionesPerfilViewController*) viewController;
        ListadoCapitulosPendientesViewController * listadoCapitulosPendientesViewController = listadoOpcionesPerfilViewController.listadoCapitulosPendientes;
        [listadoCapitulosPendientesViewController reloadTableViewFromSource:usuario.peliculasPendientes];
    }
}

@end
