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
#import "LoadableViewController.h"

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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self putBackButton];
    [self configureFrame];
	// Do any additional setup after loading the view.
}



-(void) setBackgroundColor {
    self.gradient = [CAGradientLayer layer];
    self.gradient.frame = self.view.bounds;
    UIColor * topColor = TOPCOLOR;
    UIColor * bottomColor = BOTTOMCOLOR;
    self.gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    self.gradient.startPoint = CGPointMake(0.5,0.2);
    self.gradient.endPoint = CGPointMake(0.5, 0.8);
    [self.view.layer insertSublayer:self.gradient atIndex:0];
    /*UIImage * image = BACKGROUNDIMAGE;
    image = [self imageWithImage:image scaledToSize:self.view.frame.size];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];*/
}

- (void)layoutSubviews {
    self.gradient.frame = self.view.bounds;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureFrame {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        int altoNavigationBar = -20;
        int altoTabBar = 0;
        if (self.navigationController.navigationBar) {
            if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
                altoNavigationBar = 32;
            } else {
                altoNavigationBar = 44;
            }
        }
        if (self.tabBarController.tabBar) {
            altoTabBar = self.tabBarController.tabBar.frame.size.height;
        }
        self.edgesForExtendedLayout = UIRectEdgeNone;
        CGSize screenSize = [ScreenSizeManager currentSize];
        
        CGRect viewFrame = self.view.frame;
        //viewFrame.origin.y = 0;
        viewFrame.origin.x = 0;
        viewFrame.size.height = screenSize.height - altoNavigationBar - altoTabBar;
        viewFrame.size.width = screenSize.width;
        
        self.view.frame = viewFrame;
    } else {
        if (self.navigationController.navigationBar) {
            if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
                self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
            } else {
                self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
            }
        } else {
            if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
                self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscape + 20);
            } else {
                self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortrait + 20);
            }
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
    [self layoutSubviews];
    
}

-(void) putBackButton {
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *aButton = [self crearBarButtonBoton:@"backButton.png"];
        [aButton addTarget:self action:@selector(handlerBackButtonNavigationBar) forControlEvents:UIControlEventTouchUpInside];
        self.backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
        
        self.navigationItem.hidesBackButton = YES;
        
        [self addLeftBarButtonItem:self.backButton];
    }
}



-(void) handlerBackButtonNavigationBar {
    [self stopTasks];
    if(self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) stopTasks {
    for (UIViewController * viewcontroller in self.childViewControllers) {
        if ([viewcontroller respondsToSelector:@selector(cancelThreadsAndRequests)]) {
            [viewcontroller performSelector:@selector(cancelThreadsAndRequests) withObject:nil];
        }
        [viewcontroller removeFromParentViewController];
    }
}

@end
