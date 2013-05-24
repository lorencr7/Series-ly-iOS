//
//  SeriesViewControllerIpad.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 22/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "SeriesViewControllerIpad.h"
#import "ConstantsCustomSplitViewController.h"
#import "ListadoElementsSiguiendoViewController.h"
#import "DetalleElementViewController.h"
#import "ListadoSeriesSiguiendoViewController.h"

@interface SeriesViewControllerIpad ()

@end

@implementation SeriesViewControllerIpad


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureFrame];
    [self loadListadoSeries];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.listadoElementosSiguiendoViewController = [[ListadoSeriesSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame DetalleElementViewController:self.detalleElementViewController];
    //self.listadoElementosSiguiendoViewController = [[ListadoElementsSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame SourceData:SourceSeriesSiguiendo DetalleElementViewController:self.detalleElementViewController];
    self.listadoElementosSiguiendoViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self addChildViewController:self.listadoElementosSiguiendoViewController];
    [self addChildViewController:self.detalleElementViewController];
    
    [self.view addSubview:self.listadoElementosSiguiendoViewController.view];
    [self.view addSubview:self.detalleElementViewController.view];
}

-(void) stopTasks {
    [self.detalleElementViewController cancelThreadsAndRequests];
    [self.listadoElementosSiguiendoViewController cancelThreadsAndRequests];
}

@end
