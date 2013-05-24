//
//  PerfilViewControllerIpad.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 26/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "PerfilViewControllerIpad.h"
#import "ConstantsCustomSplitViewController.h"
#import "DatosPerfilViewController.h"
#import "ListadoCapitulosPendientesViewController.h"
#import "ListadoOpcionesPerfilViewController.h"
#import "AppDelegate.h"
#import "TVFramework.h"


static PerfilViewControllerIpad * instance;


@interface PerfilViewControllerIpad ()

@end


@implementation PerfilViewControllerIpad

+(PerfilViewControllerIpad *) getInstance {
    if (instance == nil) {
        instance = [[PerfilViewControllerIpad alloc] init];
    }
    [instance reloadData];
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserInfo];
    [self loadEpisodes];//Inicializamos los tableViews que controlan los episodios pendientes
    //[self showiADBanner];
    [self showInterstitialBanner];
	// Do any additional setup after loading the view.
}

-(void) reloadData {
        [self.listadoCapitulosPendientesViewController performSelectorInBackground:@selector(loadData) withObject:nil];
        [self.datosPerfilViewController performSelectorInBackground:@selector(loadData) withObject:nil];
}

-(void) loadUserInfo {
    CGRect datosPerfilFrame = CGRectMake(0,
                                         0,
                                         self.view.frame.size.width,
                                         120);
    self.datosPerfilViewController = [[DatosPerfilViewController alloc] initWithFrame:datosPerfilFrame];
    [self addChildViewController:self.datosPerfilViewController];
    [self.view addSubview:self.datosPerfilViewController.view];
    
}

-(void) loadEpisodes {
    int anchoDiferente = 60;//diferencia de tamaño de los tableView
    
    CGRect frameViewSeleccion = CGRectMake(0,
                                           self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height,
                                           self.view.frame.size.width/2 - anchoDiferente,
                                           self.view.frame.size.height - (self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height));
    
    CGRect frameViewEpisodios = CGRectMake(frameViewSeleccion.origin.x + frameViewSeleccion.size.width,
                                           self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height,
                                           self.view.frame.size.width/2 + anchoDiferente,
                                           self.view.frame.size.height - (self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height));
    
    self.listadoCapitulosPendientesViewController = [[ListadoCapitulosPendientesViewController alloc] initWithFrame:frameViewEpisodios SourceData:SourceSeriesPendientes];
    self.listadoCapitulosPendientesViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.listadoOpcionesPerfilViewController = [[ListadoOpcionesPerfilViewController alloc] initWithFrame:frameViewSeleccion ListadoCapitulosPendientes:self.listadoCapitulosPendientesViewController];
    self.listadoOpcionesPerfilViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    
    [self addChildViewController:self.listadoOpcionesPerfilViewController];
    [self addChildViewController:self.listadoCapitulosPendientesViewController];
    
    [self.view addSubview:self.listadoOpcionesPerfilViewController.view];
    [self.view addSubview:self.listadoCapitulosPendientesViewController.view];
}

- (void) showiADBanner {
    
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    self.bannerView.delegate = self;
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    self.listadoCapitulosPendientesViewController.customTableView.tableHeaderView = banner;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    self.listadoCapitulosPendientesViewController.customTableView.tableHeaderView = nil;
    NSLog(@"bannerViewError: %@",error.localizedDescription);
}

-(void) stopTasks {
    [self.listadoOpcionesPerfilViewController cancelThreadsAndRequests];
    [self.datosPerfilViewController cancelThreadsAndRequests];
    [self.listadoCapitulosPendientesViewController cancelThreadsAndRequests];
}

@end

