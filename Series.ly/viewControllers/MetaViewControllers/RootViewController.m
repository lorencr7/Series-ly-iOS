//
//  RootViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"
#import "ScreenSizeManager.h"
#import "ConstantsCustomSplitViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)init {
    self = [super init];
    if (self) {
        //El title tiene que estar en el init, sino el tabBar del iPhone no coge el nombre de la ventana
        //self.contenido = [[UIView alloc] init];
        //self.contenido.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self putBackButton];
    [self configureFrame];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureFrame {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
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
    } else {
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
            self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
        } else {
            self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
        }
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
        } else {
            self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
        }
    }
    
}

-(void) putBackButton {
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *aButton = [self crearBarButtonBoton:@"backButton.png"];
        [aButton addTarget:self action:@selector(handlerBackButtonNavigationBar) forControlEvents:UIControlEventTouchUpInside];
        self.backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
        
        /*UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton.png"]
         style:UIBarButtonItemStylePlain
         target:self
         action:@selector(handlerBack)];*/
        self.navigationItem.leftBarButtonItem = self.backButton;
        self.navigationItem.hidesBackButton = YES;
        //[[UIBarButtonItem appearance] setBackBarButtonItem:self.backButton];
    }
}

-(UIButton *) crearBarButtonBoton: (NSString *) image {
    UIImage *buttonImageFavorite = [UIImage imageNamed:image];
    UIButton *aButtonFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
    aButtonFavorite.bounds = CGRectMake(0.0, 0.0, 32, 32);
    [aButtonFavorite setImage:buttonImageFavorite forState:UIControlStateNormal];
    return aButtonFavorite;
}

-(void) handlerBackButtonNavigationBar {
    [self stopTasks];
    if(self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) stopTasks {
    
}

@end
