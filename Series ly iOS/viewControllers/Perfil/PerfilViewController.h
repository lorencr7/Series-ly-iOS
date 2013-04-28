//
//  PerfilViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CustomTableViewController, ListadoCapitulosPendientesViewController,DatosPerfilViewController, ListadoOpcionesPerfilViewController;
@interface PerfilViewController : UIViewController


//@property (strong, nonatomic) CustomTableViewController *tableViewSeleccion;
//@property (strong, nonatomic) UIView * viewSeleccion;
@property (strong, nonatomic) ListadoOpcionesPerfilViewController * listadoOpcionesPerfilViewController;

/*@property(strong, nonatomic) UIImageView * imagenPerfil;
@property(strong, nonatomic) UILabel * labelNombreUsuario;
@property(strong, nonatomic) UILabel * labelNombreUsuarioCompleto;
@property(strong, nonatomic) UILabel * labelNombreUsuarioAlta;
@property(strong, nonatomic) UIView * viewPerfil;*/
@property(strong, nonatomic) DatosPerfilViewController * datosPerfilViewController;


@property(strong, nonatomic) UILabel * labelSeriesPendientes;

+ (void) logout;

//- (void) downloadUserInfo;
//- (void) configureUserInfo;


@end
