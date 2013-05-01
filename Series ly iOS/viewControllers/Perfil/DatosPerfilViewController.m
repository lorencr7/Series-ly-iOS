//
//  DatosPerfilViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DatosPerfilViewController.h"
#import "User.h"
#import "UserCredentials.h"
#import "ManejadorServicioWebSeriesly.h"
#import "UserExtInfo.h"
#import "UserData.h"
#import "UserImgUser.h"
#import "UserCountry.h"
#import "UserInfo.h"
#import <QuartzCore/QuartzCore.h>


@interface DatosPerfilViewController ()

@end

@implementation DatosPerfilViewController

- (id)initWithFrame: (CGRect) frame {
    self = [super init];
    if (self) {
        self.frame = frame;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.frame = self.frame;
    [self loadUserInfo];
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserInfo) object:nil];
    [thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadUserInfo {
    [self loadImage];//Inicializamos la imagen del usuario
    [self loadUserInformation];//Inicializamos los labels de la informacion de usuario
}

-(void) loadImage {
    //Asignamos el frame a la imagen de perfil. Las medidas no cambian (100x105)
    self.imagenPerfil = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 105)];
    
    // Editamos la apariencia de la foto de perfil
    /*self.imagenPerfil.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.imagenPerfil.layer.shadowOffset = CGSizeMake(3,3);
    self.imagenPerfil.layer.shadowRadius = 2;
    self.imagenPerfil.layer.shadowOpacity = 0.6;
    CGRect shadowFrame = self.imagenPerfil.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.imagenPerfil.layer.shadowPath = shadowPath;*/
    
    
    [self.view addSubview:self.imagenPerfil];
}

-(void) loadUserInformation {
    self.labelNombreUsuario = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 10, 15, 0, 22)];
    self.labelNombreUsuario.font = [UIFont boldSystemFontOfSize:18];
    self.labelNombreUsuario.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.labelNombreUsuario];
    
    self.labelNombreUsuarioCompleto = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 10, self.labelNombreUsuario.frame.origin.y + self.labelNombreUsuario.frame.size.height + 5, 0, 22)];
    self.labelNombreUsuarioCompleto.font = [UIFont systemFontOfSize:14];
    self.labelNombreUsuarioCompleto.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.labelNombreUsuarioCompleto];
    
    self.labelNombreUsuarioAlta = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 10, self.labelNombreUsuarioCompleto.frame.origin.y + self.labelNombreUsuarioCompleto.frame.size.height + 5, 0, 22)];
    self.labelNombreUsuarioAlta.font = [UIFont systemFontOfSize:14];
    self.labelNombreUsuarioAlta.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.labelNombreUsuarioAlta];
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
    //[self.view addSubview:imageView];
    
}

@end
