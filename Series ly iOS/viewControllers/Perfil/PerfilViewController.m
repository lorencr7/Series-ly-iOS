//
//  PerfilViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "PerfilViewController.h"
#import "ManejadorServicioWebSeriesly.h"
#import "ManejadorBaseDeDatosBackup.h"
#import "UserCredentials.h"
#import "User.h"
#import "AppDelegate.h"



@interface PerfilViewController ()

@end

@implementation PerfilViewController

//Codigo principal de logout. Esta funcion hace un logout de verdad
+(void) logout {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(logoutApi) object:nil];
    [thread start];
    
}

+(void) logoutApi {
    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
    //Hacemos logout en la API
    UserCredentials * userCredentials = [UserCredentials getInstance];
    [manejadorServicioWeb logoutWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
    //Borramos la informacion guardada
    [UserCredentials resetInstance];
    [User resetInstance];
    [manejadorBaseDeDatosBackup borrarUserCredentials];
    //Cargamos la ventana de log in
    AppDelegate * appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate loadLogInController];
}

- (id)init {
    self = [super init];
    if (self) {
        //El title tiene que estar en el init, sino el tabBar del iPhone no coge el nombre de la ventana
        self.title = NSLocalizedString(@"TableViewPerfilCellText", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end