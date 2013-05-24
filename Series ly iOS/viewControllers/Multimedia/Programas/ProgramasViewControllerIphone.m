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
    [self loadListadoSeries];
    [self showiADBanner];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
