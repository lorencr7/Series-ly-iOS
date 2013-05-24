//
//  ProgramasViewControllerIpad.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 22/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ProgramasViewControllerIpad.h"
#import "ConstantsCustomSplitViewController.h"
#import "ListadoElementsSiguiendoViewController.h"
#import "DetalleElementViewController.h"
#import "ListadoProgramasSiguiendoViewController.h"

@interface ProgramasViewControllerIpad ()

@end

@implementation ProgramasViewControllerIpad

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
    
    self.detalleElementViewController = [[DetalleElementViewController alloc] initWithFrame:detalleSeriesFrame MediaElementUser:nil];
    self.detalleElementViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.listadoElementosSiguiendoViewController = [[ListadoProgramasSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame DetalleElementViewController:self.detalleElementViewController];
    //self.listadoElementosSiguiendoViewController = [[ListadoElementsSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame SourceData:SourceTVShowsSiguiendo DetalleElementViewController:self.detalleElementViewController];
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
