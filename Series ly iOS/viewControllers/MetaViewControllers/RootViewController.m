//
//  RootViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
