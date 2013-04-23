//
//  VerLinkViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "VerLinkViewController.h"
#import "ConstantsCustomSplitViewController.h"
#import "PerfilViewController.h"
#import "UserCredentials.h"
#import "AuthToken.h"
#import "UserToken.h"

@interface VerLinkViewController ()

@end

@implementation VerLinkViewController

-(id) initWithIdv: (NSString *) idv {
    self = [super init];
    if (self) {
        self.idv = idv;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData {
    
}

-(void) cancelarButtonPressed: (UIButton *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation VerLinkViewControllerIpad

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
	// Do any additional setup after loading the view.
}

- (void) loadData {
    [super loadData]; // Llamamos al loadData del padre
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        self.view.frame = CGRectMake(0, 0, baseLandscape, altoDetailLandscapeConNavigationBar);
    } else {
        self.view.frame = CGRectMake(0, 0, basePortrait, altoDetailPortraitConNavigationBar);
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(cancelarButtonPressed:)];
    
    UserCredentials * userCredentials = [PerfilViewController getUserCredentials];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/media/link/go/%@?auth_token=%@&user_token=%@",self.idv,userCredentials.authToken.authToken,userCredentials.userToken.userToken];
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
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
    self.view.frame = CGRectMake(0, 0, baseLandscape, altoDetailLandscapeConNavigationBar);
}

- (void) rotateToPortrait: (NSNotification *) notification {//llamado cuando se gira a portrait
    self.view.frame = CGRectMake(0, 0, basePortrait, altoDetailPortraitConNavigationBar);
}

@end

@implementation VerLinkViewControllerIphone 

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

@end
