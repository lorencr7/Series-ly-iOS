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
        [self configureFrame];
        
        [self loadUserInfo];
        [self loadEpisodes];//Inicializamos los tableViews que controlan los episodios pendientes
        //[self showInterstitialBanner];
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
}

-(void) reloadData {
    if (!firstLoad) {
        [self.listadoCapitulosPendientesViewController performSelectorInBackground:@selector(loadData) withObject:nil];
        [self.datosPerfilViewController performSelectorInBackground:@selector(loadData) withObject:nil];
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [self reloadData];


    //Nos suscribimos a los cambios de orientacion del iPad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToLandscape:) name:@"RotateToLandscape" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToPortrait:) name:@"RotateToPortrait" object:nil];
    firstLoad = NO;
}

-(void) viewDidAppear:(BOOL)animated {
    //NSLog(@"viewDidAppear");
}

-(void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) viewDidDisappear:(BOOL)animated {
    //NSLog(@"viewDidDisappear");
}

- (void) rotateToLandscape: (NSNotification *) notification {//llamado cuando se gira a landscape
    self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
}

- (void) rotateToPortrait: (NSNotification *) notification {//llamado cuando se gira a portrait
    self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
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

/*-(void) loadInterstitialBanner {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showInterstitialBanner];
}*/

-(void) showInterstitialBanner {
    self.interstitial = [[ADInterstitialAd alloc] init];
    self.interstitial.delegate = self;
}

- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        [interstitialAd presentFromViewController:self];
    }
}

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    
}

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"interstitialAdError: %@",error.localizedDescription);
}

@end

