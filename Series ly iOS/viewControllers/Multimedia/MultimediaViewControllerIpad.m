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


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
    } else {
        self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadListadoSeries];
    [self loadDetalleSeries];
    
    //Nos suscribimos a los cambios de orientacion del iPad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToLandscape:) name:@"RotateToLandscape" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToPortrait:) name:@"RotateToPortrait" object:nil];
    
    
    //Descargamos la informacion de usuario en background
    //NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserInfo) object:nil];
    //[thread start];
}

- (void) loadData {
    
    
}
- (void) rotateToLandscape: (NSNotification *) notification {//llamado cuando se gira a landscape
    self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
}

- (void) rotateToPortrait: (NSNotification *) notification {//llamado cuando se gira a portrait
    self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
}


-(void) loadListadoSeries {
    CGRect listadoSeriesFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width/2 - 60,
                                           self.view.frame.size.height);
    self.listadoElementosSiguiendoViewController = [[ListadoElementsSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame SourceData:self.tipoSourceData];
    [self.view addSubview:self.listadoElementosSiguiendoViewController.view];
}

-(void) loadDetalleSeries {
    
}



@end