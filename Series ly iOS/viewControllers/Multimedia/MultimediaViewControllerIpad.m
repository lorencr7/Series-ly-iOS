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
#import "DetalleElementViewController.h"

static MultimediaViewControllerIpad * instance;

@interface MultimediaViewControllerIpad ()

@end

@implementation MultimediaViewControllerIpad

+(MultimediaViewControllerIpad *) getInstance {
    if (instance == nil) {
        instance = [[MultimediaViewControllerIpad alloc] init];
    }
    
    return instance;
}

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
        self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
    } else {
        self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToLandscape:) name:@"RotateToLandscape" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToPortrait:) name:@"RotateToPortrait" object:nil];
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
    CGRect detalleSeriesFrame = CGRectMake(listadoSeriesFrame.origin.x + listadoSeriesFrame.size.width,
                                           0,
                                           self.view.frame.size.width - listadoSeriesFrame.size.width,
                                           self.view.frame.size.height);
    
    self.detalleElementViewController = [[DetalleElementViewController alloc] initWithFrame:detalleSeriesFrame MediaElementUser:nil];
    self.detalleElementViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.listadoElementosSiguiendoViewController = [[ListadoElementsSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame SourceData:self.tipoSourceData DetalleElementViewController:self.detalleElementViewController];
    self.listadoElementosSiguiendoViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    [self addChildViewController:self.listadoElementosSiguiendoViewController];
    [self addChildViewController:self.detalleElementViewController];
    
    [self.view addSubview:self.listadoElementosSiguiendoViewController.view];
    [self.view addSubview:self.detalleElementViewController.view];
}

-(void) loadDetalleSeries {
    
}



@end
