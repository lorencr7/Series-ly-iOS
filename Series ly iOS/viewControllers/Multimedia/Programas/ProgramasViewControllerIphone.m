//
//  ProgramasViewControllerIphone.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 22/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ProgramasViewControllerIphone.h"
#import "TVFramework.h"
#import "ScreenSizeManager.h"
#import "ListadoProgramasSiguiendoViewController.h"

@interface ProgramasViewControllerIphone ()

@end

@implementation ProgramasViewControllerIphone

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureFrame];
    [self loadListadoSeries];
    [self showiADBanner];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureFrame {
    int altoNavigationBar;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        altoNavigationBar = 32;
    } else {
        altoNavigationBar = 44;
    }
    
    CGSize screenSize = [ScreenSizeManager currentSize];
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    viewFrame.origin.x = 0;
    viewFrame.size.height = screenSize.height - altoNavigationBar;
    viewFrame.size.width = screenSize.width;
    
    self.view.frame = viewFrame;
}

-(void) loadListadoSeries {
    CGRect listadoSeriesFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           self.view.frame.size.height);
    self.listadoElementosSiguiendoViewController = [[ListadoProgramasSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame DetalleElementViewController:nil];
    //self.listadoElementosSiguiendoViewController = [[ListadoElementsSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame SourceData:SourceTVShowsSiguiendo DetalleElementViewController:nil];
    self.listadoElementosSiguiendoViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    [self addChildViewController:self.listadoElementosSiguiendoViewController];
    [self.view addSubview:self.listadoElementosSiguiendoViewController.view];
}




- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    self.listadoElementosSiguiendoViewController.customTableView.tableHeaderView = banner;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    self.listadoElementosSiguiendoViewController.customTableView.tableHeaderView = nil;
    NSLog(@"bannerViewError: %@",error.localizedDescription);
}

-(void) stopTasks {
    [self.listadoElementosSiguiendoViewController cancelThreadsAndRequests];
}

@end
