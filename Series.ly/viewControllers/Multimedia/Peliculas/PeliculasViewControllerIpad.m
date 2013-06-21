//
//  PeliculasViewControllerIpad.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 22/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "PeliculasViewControllerIpad.h"
#import "ConstantsCustomSplitViewController.h"
#import "ListadoElementsSiguiendoViewController.h"
#import "DetalleElementViewController.h"
#import "ListadoPeliculasSiguiendoViewController.h"

@interface PeliculasViewControllerIpad ()

@end

@implementation PeliculasViewControllerIpad

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadListadoSeries];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    self.detalleElementViewController = [[DetalleElementViewController alloc] initWithFrame:detalleSeriesFrame MediaElement:nil];
    [self addChildViewController:self.detalleElementViewController];
    self.detalleElementViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.listadoElementosSiguiendoViewController = [[ListadoPeliculasSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame DetalleElementViewController:self.detalleElementViewController];
    [self addChildViewController:self.listadoElementosSiguiendoViewController];
    //self.listadoElementosSiguiendoViewController = [[ListadoElementsSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame SourceData:SourcePeliculasSiguiendo DetalleElementViewController:self.detalleElementViewController];
    self.listadoElementosSiguiendoViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    
    
    
    [self.view addSubview:self.listadoElementosSiguiendoViewController.view];
    [self.view addSubview:self.detalleElementViewController.view];
}

-(void) stopTasks {
    [self.detalleElementViewController cancelThreadsAndRequests];
    [self.listadoElementosSiguiendoViewController cancelThreadsAndRequests];
}

@end