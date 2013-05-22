//
//  AjustesViewControllerIphone.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 20/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "AjustesViewControllerIphone.h"
#import "ScreenSizeManager.h"
#import "AcercaDeViewController.h"

@interface AjustesViewControllerIphone ()

@end

@implementation AjustesViewControllerIphone

- (id)init {
    self = [super init];
    if (self) {
        

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureFrame];
    self.acercaDeViewController = [[AcercaDeViewController alloc] initWithFrame:self.view.frame];
    self.acercaDeViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.acercaDeViewController.view];
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

@end
