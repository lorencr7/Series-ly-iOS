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


static User * usuario;
static UserCredentials * userCredentials;

@interface PerfilViewController ()

@end

@implementation PerfilViewController

+(User *) getUsuario {
    return usuario;
}

+(void) setUsuario: (User *) user {
    usuario = user;
}

+(UserCredentials *) getUserCredentials {
    return userCredentials;
}

+(void) setUserCredentials: (UserCredentials *) credentials {
    userCredentials = credentials;
}

//Codigo principal de logout. Esta funcion hace un logout de verdad
+(void) logout {

    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(logoutApi) object:nil];
    [thread start];
    
}

+(void) logoutApi {
    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
    //Hacemos logout en la API
    [manejadorServicioWeb logoutWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
    //Borramos la informacion guardada
    userCredentials = nil;
    usuario = nil;
    //[manejadorBaseDeDatosBackup borrarInformacionUsuario];
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
    if (!usuario) {
        usuario = [[User alloc] init];
    }
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

-(void) downloadUserPendingInfo {
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    
    NSString * nombreUser = usuario.userInfo.userData.nick;
    BOOL nuevaInfo = NO;
    if (usuario.seriesPendientes) {
        [self fillTableViewFromSource:usuario.seriesPendientes];
        SectionElement * secionElement = [self.tableViewSeleccion.section.sections objectAtIndex:0];
        CustomCellPerfilSeleccionSeriesPendientes * customCellPerfilSeleccionSeriesPendiente = [secionElement.cells objectAtIndex:0];
        [customCellPerfilSeleccionSeriesPendiente customSelect];
        
        [self.tableViewSeleccion selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    //Descargamos los capitulos de las series pendientes del usuario
    //NSLog(@"iniciando descarga info pendiente");
    NSMutableDictionary * userPendingInfo = [manejadorServicioWebSeriesly getUserPendingInfoWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
    if (!userPendingInfo) {
        NSLog(@"error descargando la info de pendientes del usuario: %@",nombreUser);
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ups" message:@"No se pudo descargar los capítulos pendientes" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        //NSLog(@"info pendiente descargada");
        usuario.seriesPendientes = [userPendingInfo objectForKey:@"series"];
        usuario.peliculasPendientes = [userPendingInfo objectForKey:@"movies"];
        usuario.documentalesPendientes = [userPendingInfo objectForKey:@"documentaries"];
        usuario.tvShowsPendientes = [userPendingInfo objectForKey:@"tvshows"];
        nuevaInfo = YES;
        //Rellenamos el tableView de la derecha con los capitulos de series pendientes
        
    }
    if (nuevaInfo) {
        [self fillTableViewFromSource:usuario.seriesPendientes];
        //Le decimos al tableView de la izquierda que su primera celda es la que ha sido pulsada (series pendientes)
        SectionElement * secionElement = [self.tableViewSeleccion.section.sections objectAtIndex:0];
        CustomCellPerfilSeleccionSeriesPendientes * customCellPerfilSeleccionSeriesPendiente = [secionElement.cells objectAtIndex:0];
        [customCellPerfilSeleccionSeriesPendiente customSelect];
        
        [self.tableViewSeleccion selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else {
        
    }
    
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

//Este metodo crea una celda del tableView de la derecha a partir de un mediaElement
-(CustomCellPerfilListadoCapitulos *) createCellListadoCapitulosWithMediaElementUserPending: (MediaElementUserPending *) mediaElementUserPending {
    UIView * backgroundView = [[UIView alloc] init];
    int altoCelda = 0;
    int margen = 15;
    int separacionDelPoster = 25;
    UIImageView * poster = [[UIImageView alloc] initWithFrame:CGRectMake(margen, margen, 87.5, 130)];
    poster.layer.cornerRadius = 6.0f;
    poster.clipsToBounds = YES;
    NSString * urlImagen = mediaElementUserPending.poster.large;
    if (urlImagen) {
        NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
        [arguments setObject:poster forKey:@"imageView"];
        [arguments setObject:urlImagen forKey:@"url"];
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureImageView:) object:arguments];
        [thread start];
    }
    
    
    UILabel * labelSerie = [[UILabel alloc] initWithFrame:CGRectMake(poster.frame.origin.x + poster.frame.size.width + separacionDelPoster,
                                                                     poster.frame.origin.y + poster.frame.size.height/2 - 22/2 - 30,
                                                                     self.tableViewEpisodios.frame.size.width - poster.frame.size.width - separacionDelPoster - 80,
                                                                     0)];
    labelSerie.text = [NSString stringWithFormat:@"%@",mediaElementUserPending.name];
    labelSerie.backgroundColor = [UIColor clearColor];
    labelSerie.font = [UIFont boldSystemFontOfSize:18];
    labelSerie.numberOfLines = 2;
    [labelSerie sizeToFit];
    UILabel * labelEpisodio;
    //if (![mediaElementUserPending.pending.full isEqualToString:@"(null)"]) {
    if (mediaElementUserPending.pending.full) {
        labelEpisodio = [[UILabel alloc] initWithFrame:CGRectMake(poster.frame.origin.x + poster.frame.size.width + separacionDelPoster, labelSerie.frame.origin.y + labelSerie.frame.size.height, 0, 0)];
        labelEpisodio.text = [NSString stringWithFormat:@"%@",mediaElementUserPending.pending.full];
        labelEpisodio.backgroundColor = [UIColor clearColor];
        labelEpisodio.font = [UIFont systemFontOfSize:17];
        [labelEpisodio sizeToFit];
    }
    
    
    altoCelda = poster.frame.origin.y + poster.frame.size.height + margen;
    
    [backgroundView addSubview:poster];
    [backgroundView addSubview:labelSerie];
    [backgroundView addSubview:labelEpisodio];
    
    
    CustomCellPerfilListadoCapitulos * customCellPerfilListadoCapitulos = [[CustomCellPerfilListadoCapitulos alloc] initWithMediaElementUserPending:mediaElementUserPending];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIALISTADOCAPITULOS(backgroundView, altoCelda) cellText:nil selectionType:YES customCell:customCellPerfilListadoCapitulos];
    return customCellPerfilListadoCapitulos;
}

//Metodo que rellena el tableView de la derecha a partir de un array de mediaElements y lo muestra con una animacion
//No se debe llamar a este metodo, llamar en su lugar a: -(void) fillTableViewFromSource:
-(void) fillTableViewInBackgroundFromSource:(NSMutableArray *)source {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    for (MediaElementUserPending * mediaElementUserPending in source) {
        [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:mediaElementUserPending]];
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    [sections addObject:sectionElement];
    self.tableViewEpisodios.section.sections = sections;
    [self.tableViewEpisodios reloadData];
    //solo se hace la animacion si la tabla contiene contenido
    if (cells.count > 0) {
        CGRect newFrame = self.viewEpisodios.frame;
        newFrame.origin.x = self.viewSeleccion.frame.origin.x + self.viewSeleccion.frame.size.width;
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.viewEpisodios.alpha = 1.0;
            self.viewEpisodios.frame = newFrame;
        } completion:^(BOOL finished){
            
        }];
    }
}

//idem que metodo anterior pero lanzando un thread. Se debe llamar a este metodo
- (void) fillTableViewFromSource: (NSMutableArray *) source {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(fillTableViewInBackgroundFromSource:) object:source];
    [thread start];
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













/************************************************************************************************************************
 ************************************************************************************************************************
 ****************************** PerfilViewControllerIpad ****************************************************************
 ************************************************************************************************************************
 ************************************************************************************************************************/















/************************************************************************************************************************
 ************************************************************************************************************************
 ****************************** PerfilViewControllerIphone **************************************************************
 ************************************************************************************************************************
 ************************************************************************************************************************/



