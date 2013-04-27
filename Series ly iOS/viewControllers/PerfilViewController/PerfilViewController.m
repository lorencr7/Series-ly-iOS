//
//  PerfilViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "PerfilViewController.h"
#import "ManejadorServicioWebSeriesly.h"
#import "UserToken.h"
#import "AuthToken.h"
#import "User.h"
#import "UserExtInfo.h"
#import "UserData.h"
#import "UserImgUser.h"
#import "UserCountry.h"
#import "UserCredentials.h"
#import "ScreenSizeManager.h"
#import <QuartzCore/QuartzCore.h>
#import "TVFramework.h"
#import "MediaElementUserPending.h"
#import "Pending.h"
#import "ConstantsCustomSplitViewController.h"
#import "CustomCellsSeleccionPerfil.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomCellPerfilListadoCapitulos.h"
#import "ManejadorBaseDeDatosBackup.h"
#import "Poster.h"
#import "AppDelegate.h"
#import "UserInfo.h"


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

- (void) loadData {
    
    //Descargamos la informacion de usuario en background
    
}

-(void) downloadUserInfo {
    User * usuario = [User getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    //Descargamos la informacion del usuario
    UserInfo * userInfo = [manejadorServicioWebSeriesly getUserInfoWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
    if (!userInfo) {
        NSLog(@"error descargando la info del usuario");
    } else {
        usuario.userInfo = userInfo;
        [self configureUserInfo];
    }
    
    //NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureUserInfo) object:nil];
    //[thread start];
    
}

- (void) configureUserInfo {
    User * usuario = [User getInstance];
    if (usuario.userInfo.userData.imgUser.big) {//Si hay url para la imagen de perfil, la descargamos
        NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
        [arguments setObject:self.imagenPerfil forKey:@"imageView"];
        [arguments setObject:usuario.userInfo.userData.imgUser.big forKey:@"url"];
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureImageView:) object:arguments];
        [thread start];
    }
    
    //Rellenamos el label del nombre de usuario
    self.labelNombreUsuario.text = [NSString stringWithFormat:@"@%@",usuario.userInfo.userData.nick];
    [self.labelNombreUsuario sizeToFit];
    
    //Rellenamos el label del nombre de usuario completo
    self.labelNombreUsuarioCompleto.text = [NSString stringWithFormat:@"%@, %@ puntos", usuario.userInfo.extInfo.nom, usuario.userInfo.userData.punts];
    [self.labelNombreUsuarioCompleto sizeToFit];
    
    //Rellenamos el label del nombre de usuario alta
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * date = [dateFormat dateFromString:usuario.userInfo.userData.dataAlta];
    dateFormat.dateFormat = @"dd/MM/yyyy";
    self.labelNombreUsuarioAlta.text = [NSString stringWithFormat:@"Desde %@ en series.ly", [dateFormat stringFromDate:date]];
    [self.labelNombreUsuarioAlta sizeToFit];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
}

//Este metodo se descarga una imagen de internet y la asigna a su imageView correspondiente
-(void) configureImageView: (NSMutableDictionary *) arguments {
    UIImageView * imageView = [arguments objectForKey:@"imageView"];
    NSString * url = [arguments objectForKey:@"url"];
    UIImage * imagen;
    NSURL * imageURL = [NSURL URLWithString:url];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    imagen = [UIImage imageWithData:imageData];
    imageView.image = imagen;
    
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


-(void) handlerLogout {
    [PerfilViewController logout];
}

@end