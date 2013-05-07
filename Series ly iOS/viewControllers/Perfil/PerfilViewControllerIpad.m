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

@interface PerfilViewControllerIpad ()

@end


@implementation PerfilViewControllerIpad


- (id)init {
    self = [super init];
    if (self) {
        [self configureFrame];
        
        [self loadUserInfo];
        [self loadEpisodes];//Inicializamos los tableViews que controlan los episodios pendientes
        //[self loadInterstitialBanner];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void) configureFrame {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        self.contenido.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
    } else {
        self.contenido.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
    }
}


-(void) viewWillAppear:(BOOL)animated {
    //Nos suscribimos a los cambios de orientacion del iPad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToLandscape:) name:@"RotateToLandscape" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToPortrait:) name:@"RotateToPortrait" object:nil];
}

-(void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) rotateToLandscape: (NSNotification *) notification {//llamado cuando se gira a landscape
    self.contenido.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
}

- (void) rotateToPortrait: (NSNotification *) notification {//llamado cuando se gira a portrait
    self.contenido.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
}

-(void) loadUserInfo {
    CGRect datosPerfilFrame = CGRectMake(0,
                                         0,
                                         self.contenido.frame.size.width,
                                         120);
    self.datosPerfilViewController = [[DatosPerfilViewController alloc] initWithFrame:datosPerfilFrame];
    [self.contenido addSubview:self.datosPerfilViewController.view];
    
}


-(void) loadEpisodes {
    int anchoDiferente = 60;//diferencia de tamaño de los tableView
    
    CGRect frameViewSeleccion = CGRectMake(0,
                                           self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height,
                                           self.contenido.frame.size.width/2 - anchoDiferente,
                                           self.contenido.frame.size.height - (self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height));
    
    CGRect frameViewEpisodios = CGRectMake(frameViewSeleccion.origin.x + frameViewSeleccion.size.width,
                                           self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height,
                                           self.contenido.frame.size.width/2 + anchoDiferente,
                                           self.contenido.frame.size.height - (self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height));
    
    self.listadoCapitulosPendientesViewController = [[ListadoCapitulosPendientesViewController alloc] initWithFrame:frameViewEpisodios SourceData:SourceSeriesPendientes];
    self.listadoOpcionesPerfilViewController = [[ListadoOpcionesPerfilViewController alloc] initWithFrame:frameViewSeleccion ListadoCapitulosPendientes:self.listadoCapitulosPendientesViewController];
    
    [self.contenido addSubview:self.listadoOpcionesPerfilViewController.view];
    [self.contenido addSubview:self.listadoCapitulosPendientesViewController.view];
}

-(void) loadInterstitialBanner {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showInterstitialBanner];
}

@end

