//
//  MultimediaViewControllerIphone.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MultimediaViewControllerIphone.h"
#import "TVFramework.h"
#import "ScreenSizeManager.h"

@interface MultimediaViewControllerIphone ()

@end

@implementation MultimediaViewControllerIphone

- (id)initWithTitle: (NSString *) title TipoSourceData: (TipoSourceDataSiguiendo) tipoSourceData {
    self = [super initWithTitle:title TipoSourceData:tipoSourceData];
    if (self) {
        [self configureFrame];
        [self loadListadoSeries];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

/*-(void) viewDidAppear:(BOOL)animated {
    if (self.listadoElementosSiguiendoViewController.customTableView.lastCellPressed) {
        [self.listadoElementosSiguiendoViewController.customTableView.lastCellPressed customDeselect];
    }
}*/

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
    self.listadoElementosSiguiendoViewController = [[ListadoElementsSiguiendoViewController alloc] initWithFrame:listadoSeriesFrame SourceData:self.tipoSourceData];
    self.listadoElementosSiguiendoViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    
    [self addChildViewController:self.listadoElementosSiguiendoViewController];
    [self.view addSubview:self.listadoElementosSiguiendoViewController.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
