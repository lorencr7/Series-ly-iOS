//
//  MultimediaViewControllerIpad.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MultimediaViewControllerIpad.h"
#import "ConstantsCustomSplitViewController.h"
#import "ListadoElementsSiguiendoViewController.h"

@interface MultimediaViewControllerIpad ()

@end

@implementation MultimediaViewControllerIpad

- (id)initWithTitle: (NSString *) title TipoSourceData: (TipoSourceDataSiguiendo) tipoSourceData {
    self = [super initWithTitle:title TipoSourceData:tipoSourceData];
    if (self) {
        [self configureFrame];
        [self loadListadoSeries];
        [self loadDetalleSeries];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void) configureFrame {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        self.contenido.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
    } else {
        self.contenido.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
    }
    self.contenido.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToLandscape:) name:@"RotateToLandscape" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToPortrait:) name:@"RotateToPortrait" object:nil];
}


- (void) rotateToLandscape: (NSNotification *) notification {//llamado cuando se gira a landscape
    self.contenido.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
}

- (void) rotateToPortrait: (NSNotification *) notification {//llamado cuando se gira a portrait
    self.contenido.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
}


-(void) loadListadoSeries {
    CGRect listadoSeriesFrame = CGRectMake(0,
                                           0,
                                           self.contenido.frame.size.width/2 - 60,
                                           self.contenido.frame.size.height);
    self.listadoElementosSiguiendoViewController = [[ListadoElementsSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame SourceData:self.tipoSourceData];
    [self.contenido addSubview:self.listadoElementosSiguiendoViewController.view];
}

-(void) loadDetalleSeries {
    
}



@end
