//
//  VerCapitulosPendientesViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListadoCapitulosPendientesViewController.h"

//@class ListadoCapitulosPendientesViewController;
@interface VerCapitulosPendientesViewController : UIViewController

@property(strong, nonatomic) ListadoCapitulosPendientesViewController * listadoCapitulosPendientesViewController;
@property (assign, nonatomic) TipoSourceData tipoSourceData;

- (id)initWithTitle: (NSString *) title SourceData: (TipoSourceData) sourceData;

@end
