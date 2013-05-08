//
//  DatosPerfilViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DownloadableViewController.h"

@interface DatosPerfilViewController : DownloadableViewController

@property (assign, nonatomic) CGRect frame;

@property(strong, nonatomic) UIImageView * imagenPerfil;
@property(strong, nonatomic) UILabel * labelNombreUsuario;
@property(strong, nonatomic) UILabel * labelNombreUsuarioCompleto;
@property(strong, nonatomic) UILabel * labelNombreUsuarioAlta;

- (id)initWithFrame: (CGRect) frame;

@end
