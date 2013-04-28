//
//  ListadoOpcionesPerfilViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableViewController,ListadoCapitulosPendientesViewController;
@interface ListadoOpcionesPerfilViewController : UIViewController

@property (assign, nonatomic) CGRect frame;
@property (strong, nonatomic) CustomTableViewController *tableViewSeleccion;
@property (strong, nonatomic) ListadoCapitulosPendientesViewController *listadoCapitulosPendientes;

- (id)initWithFrame: (CGRect) frame ListadoCapitulosPendientes: (ListadoCapitulosPendientesViewController *) listadoCapitulosPendientes;

@end
