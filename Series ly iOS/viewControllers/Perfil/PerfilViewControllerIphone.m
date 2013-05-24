//
//  PerfilViewControllerIphone.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 26/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "PerfilViewControllerIphone.h"
#import "DatosPerfilViewController.h"
#import "ListadoOpcionesPerfilViewController.h"
#import "ScreenSizeManager.h"
#import "TVFramework.h"

static PerfilViewControllerIphone * instance;


@interface PerfilViewControllerIphone ()

@end

@implementation PerfilViewControllerIphone

+(PerfilViewControllerIphone *) getInstance {
    if (instance == nil) {
        instance = [[PerfilViewControllerIphone alloc] init];
    }
    [instance reloadData];
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self loadUserInfo];
        [self loadEpisodes];//Inicializamos los tableViews que controlan los episodios pendientes
        [self showiADBanner];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) reloadData {
        [self.datosPerfilViewController performSelectorInBackground:@selector(loadData) withObject:nil];
}

-(void) viewWillAppear:(BOOL)animated {

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
    CGRect frameViewSeleccion = CGRectMake(0,
                                           self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height,
                                           self.view.frame.size.width,
                                           self.view.frame.size.height - (self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height));
    self.listadoOpcionesPerfilViewController = [[ListadoOpcionesPerfilViewController alloc] initWithFrame:frameViewSeleccion ListadoCapitulosPendientes:nil];
    self.listadoOpcionesPerfilViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addChildViewController:self.listadoOpcionesPerfilViewController];
    [self.view addSubview:self.listadoOpcionesPerfilViewController.view];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        
    } else {
        
    }
}



- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    self.listadoOpcionesPerfilViewController.customTableView.tableHeaderView = banner;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    self.listadoOpcionesPerfilViewController.customTableView.tableHeaderView = nil;
    NSLog(@"bannerViewError: %@",error.localizedDescription);
}

-(void) stopTasks {
    [self.listadoOpcionesPerfilViewController cancelThreadsAndRequests];
    [self.datosPerfilViewController cancelThreadsAndRequests];
}

@end
