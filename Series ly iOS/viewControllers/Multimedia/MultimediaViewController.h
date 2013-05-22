//
//  MultimediaViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"

@class ListadoElementsSiguiendoViewController;
@interface MultimediaViewController : RootViewController

@property(strong, nonatomic) ListadoElementsSiguiendoViewController * listadoElementosSiguiendoViewController;

+(MultimediaViewController *) getInstance;


@end

