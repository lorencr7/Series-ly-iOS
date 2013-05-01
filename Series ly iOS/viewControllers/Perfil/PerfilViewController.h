//
//  PerfilViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"

@class CustomTableViewController, ListadoCapitulosPendientesViewController,DatosPerfilViewController, ListadoOpcionesPerfilViewController;
@interface PerfilViewController : RootViewController

@property (strong, nonatomic) ListadoOpcionesPerfilViewController * listadoOpcionesPerfilViewController;

@property (strong, nonatomic) DatosPerfilViewController * datosPerfilViewController;


+ (void) logout;



@end
