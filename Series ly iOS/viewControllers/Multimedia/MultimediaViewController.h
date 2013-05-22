//
//  MultimediaViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"
#import "ListadoElementsSiguiendoViewController.h"

@interface MultimediaViewController : RootViewController

@property(assign, nonatomic) TipoSourceDataSiguiendo tipoSourceData;

@property(strong, nonatomic) ListadoElementsSiguiendoViewController * listadoElementosSiguiendoViewController;

- (id)initWithTitle: (NSString *) title TipoSourceData: (TipoSourceDataSiguiendo) tipoSourceData;

+(MultimediaViewController *) getInstance;


@end

