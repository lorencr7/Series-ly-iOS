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
#import "Link.h"

@interface VerLinkViewController ()

@end

@implementation VerLinkViewController

-(id) initWithLink: (Link *) link {
    self = [super init];
    if (self) {
        self.link = link;
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
    //self.navigationController.navigationBarHidden = YES;
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
    UserCredentials * userCredentials = [UserCredentials getInstance];

    //UserCredentials * userCredentials = [PerfilViewController getUserCredentials];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/media/link/go/%@?auth_token=%@&user_token=%@",self.link.idv,userCredentials.authToken.authToken,userCredentials.userToken.userToken];
    //NSLog(@"url de webview: %@",self.link.idv);
    
    NSURL * url = [NSURL URLWithString:urlString];
    //[[UIApplication sharedApplication] openURL:url];
    NSMutableURLRequest * request = [NSURLRequest requestWithURL:url];
    //[request setValue:@"User-Agent Safari/528.16"  forHTTPHeaderField:@"User_Agent"];
    //[request setValue:@"User-Agent Safari/528.16" forKey:@"User_Agent"];
    //request setva
     //[request setValue:[NSString stringWithFormat:@"%@ Safari/528.16", [request valueForHTTPHeaderField:@"User-Agent"]] forHTTPHeaderField:@"User_Agent"];
    
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
