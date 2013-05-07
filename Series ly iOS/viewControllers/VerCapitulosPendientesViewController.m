//
//  VerCapitulosPendientesViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "VerCapitulosPendientesViewController.h"
#import "ScreenSizeManager.h"
#import "ListadoCapitulosPendientesViewController.h"
#import "TVFramework.h"
#import "User.h"

@interface VerCapitulosPendientesViewController ()

@end

@implementation VerCapitulosPendientesViewController

- (id)initWithTitle: (NSString *) title SourceData: (TipoSourceData) sourceData {
    self = [super init];
    if (self) {
        self.title = title;
        self.tipoSourceData = sourceData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureFrame];
    

    self.listadoCapitulosPendientesViewController = [[ListadoCapitulosPendientesViewController alloc] initWithFrame:self.view.frame SourceData:self.tipoSourceData];
    [self.view addSubview:self.listadoCapitulosPendientesViewController.view];
	// Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated {
    if (self.listadoCapitulosPendientesViewController.tableViewEpisodios.lastCellPressed) {
        [self.listadoCapitulosPendientesViewController.tableViewEpisodios.lastCellPressed customDeselect];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
