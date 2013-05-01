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

#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "DetailViewController.h"

@interface PerfilViewControllerIphone ()

@end

@implementation PerfilViewControllerIphone

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureFrame];
    
    [self loadUserInfo];
    [self loadEpisodes];//Inicializamos los tableViews que controlan los episodios pendientes
    [self loadiADBanner];
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

-(void) viewDidAppear:(BOOL)animated {
    if (self.listadoOpcionesPerfilViewController.tableViewSeleccion.lastCellPressed) {
        [self.listadoOpcionesPerfilViewController.tableViewSeleccion.lastCellPressed customDeselect];
    }
}



-(void) loadUserInfo {
    CGRect datosPerfilFrame = CGRectMake(0,
                                         0,
                                         self.view.frame.size.width,
                                         120);
    self.datosPerfilViewController = [[DatosPerfilViewController alloc] initWithFrame:datosPerfilFrame];
    [self.view addSubview:self.datosPerfilViewController.view];
}

-(void) loadEpisodes {
    CGRect frameViewSeleccion = CGRectMake(0,
                                           self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height,
                                           self.view.frame.size.width,
                                           self.view.frame.size.height - (self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height));
    self.listadoOpcionesPerfilViewController = [[ListadoOpcionesPerfilViewController alloc] initWithFrame:frameViewSeleccion ListadoCapitulosPendientes:nil];
    [self.view addSubview:self.listadoOpcionesPerfilViewController.view];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        
    } else {
        
    }
}

-(void) loadiADBanner {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController * navController = [appDelegate.drawerViewController.viewControllers objectAtIndex:1];
    DetailViewController * detailViewController = [navController.viewControllers objectAtIndex:0];
    [detailViewController showiADBanner];
}


@end
