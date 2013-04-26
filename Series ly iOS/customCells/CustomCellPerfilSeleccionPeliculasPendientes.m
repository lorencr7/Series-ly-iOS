//
//  CustomCellPerfilSeleccionPeliculasPendientes.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 07/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPerfilSeleccionPeliculasPendientes.h"
#import "PerfilViewControllerIpad.h"
#import "User.h"

@implementation CustomCellPerfilSeleccionPeliculasPendientes

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [PerfilViewControllerIpad class]) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
        } else {
            User * usuario = [PerfilViewController getUsuario];
            PerfilViewControllerIpad * perfilViewControllerIpad = (PerfilViewControllerIpad *) viewController;
            [perfilViewControllerIpad fillTableViewFromSource:usuario.peliculasPendientes];
        }
    }
}

@end
