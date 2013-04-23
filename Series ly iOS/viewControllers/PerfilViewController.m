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
    self.view.backgroundColor = [UIColor whiteColor];
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
        //[alertView show];
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
    if (![mediaElementUserPending.pending.full isEqualToString:@"(null)"]) {
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
        //[cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:mediaElementUserPending]];
        //[cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:mediaElementUserPending]];
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    [sections addObject:sectionElement];
    self.tableViewEpisodios.section.sections = sections;
    [self.tableViewEpisodios reloadData];
    //solo se hace la animacion si la tabla contiene contenido
    if (cells.count > 0) {
        CGRect oldFrame = self.viewEpisodios.frame;
        CGRect newFrame = self.viewEpisodios.frame;
        newFrame.origin.x = newFrame.origin.x + newFrame.size.width/3;
        self.viewEpisodios.frame = newFrame;
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.viewEpisodios.alpha = 1.0;
            self.viewEpisodios.frame = oldFrame;
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

@implementation PerfilViewControllerIpad


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
}

- (void) loadData {
    [super loadData]; // Llamamos al loadData del padre
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
    } else {
        self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
    }
    
    [self loadUserInfo];
    [self loadEpisodes];//Inicializamos los tableViews que controlan los episodios pendientes
    
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserInfo) object:nil];
    [thread start];
    NSThread * thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserPendingInfo) object:nil];
    [thread2 start];
    
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
    self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
}

- (void) rotateToPortrait: (NSNotification *) notification {//llamado cuando se gira a portrait
    self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
}

- (void) configureUserInfo {
    [super configureUserInfo];
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        /*self.imagenPerfil.alpha = 1.0;
         self.labelNombreUsuario.alpha = 1.0;
         self.labelNombreUsuarioCompleto.alpha = 1.0;
         self.labelNombreUsuarioAlta.alpha = 1.0;*/
        self.viewPerfil.alpha = 1.0;
        self.viewSeleccion.alpha = 1.0;
        //self.viewEpisodios.alpha = 1.0;
    } completion:^(BOOL finished){
        
    }];
    //[self downloadUserPendingInfo];
    //NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserPendingInfo) object:nil];
    //[thread start];
}

-(void) loadUserInfo {
    self.viewPerfil = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15 + 105)];
    self.viewPerfil.backgroundColor = [UIColor whiteColor];
    self.viewPerfil.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.viewPerfil.alpha = 0.0;
    [self.view addSubview:self.viewPerfil];
    
    [self loadImage];//Inicializamos la imagen del usuario
    [self loadUserInformation];//Inicializamos los labels de la informacion de usuario
}

-(void) loadImage {
    //Asignamos el frame a la imagen de perfil. Las medidas no cambian (100x105)
    self.imagenPerfil = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 100, 105)];
    
    // Editamos la apariencia de la foto de perfil
    self.imagenPerfil.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.imagenPerfil.layer.shadowOffset = CGSizeMake(3,3);
    self.imagenPerfil.layer.shadowRadius = 2;
    self.imagenPerfil.layer.shadowOpacity = 0.6;
    
    
    [self.viewPerfil addSubview:self.imagenPerfil];
}

-(void) loadUserInformation {
    self.labelNombreUsuario = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 20, 15, 0, 22)];
    self.labelNombreUsuario.font = [UIFont boldSystemFontOfSize:18];
    self.labelNombreUsuario.backgroundColor = [UIColor clearColor];
    [self.viewPerfil addSubview:self.labelNombreUsuario];
    
    self.labelNombreUsuarioCompleto = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 30, self.labelNombreUsuario.frame.origin.y + self.labelNombreUsuario.frame.size.height + 5, 0, 22)];
    self.labelNombreUsuarioCompleto.font = [UIFont systemFontOfSize:14];
    self.labelNombreUsuarioCompleto.backgroundColor = [UIColor clearColor];
    [self.viewPerfil addSubview:self.labelNombreUsuarioCompleto];
    
    self.labelNombreUsuarioAlta = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 30, self.labelNombreUsuarioCompleto.frame.origin.y + self.labelNombreUsuarioCompleto.frame.size.height + 5, 0, 22)];
    self.labelNombreUsuarioAlta.font = [UIFont systemFontOfSize:14];
    self.labelNombreUsuarioAlta.backgroundColor = [UIColor clearColor];
    [self.viewPerfil addSubview:self.labelNombreUsuarioAlta];
}

-(void) loadEpisodes {
    int separacion = 15;//separacion entre la imagen de perfil y los tableView
    int anchoDiferente = 60;//diferencia de tamaño de los tableView
    
    CGRect frameViewSeleccion = CGRectMake(0,
                                           self.imagenPerfil.frame.origin.y + self.imagenPerfil.frame.size.height + separacion,
                                           self.view.frame.size.width/2 - anchoDiferente,
                                           self.view.frame.size.height - (self.imagenPerfil.frame.origin.y + self.imagenPerfil.frame.size.height));
    CGRect frameTableViewSeleccion = CGRectMake(0,
                                                0,
                                                frameViewSeleccion.size.width,
                                                frameViewSeleccion.size.height);
    CGRect frameViewEpisodios = CGRectMake(self.tableViewSeleccion.frame.origin.x + frameTableViewSeleccion.size.width,
                                           self.imagenPerfil.frame.origin.y + self.imagenPerfil.frame.size.height + separacion,
                                           self.view.frame.size.width/2 + anchoDiferente,
                                           self.view.frame.size.height - (self.imagenPerfil.frame.origin.y + self.imagenPerfil.frame.size.height + separacion));
    CGRect frameTableViewEpisodios = CGRectMake(0,
                                                0,
                                                frameViewEpisodios.size.width,
                                                frameViewEpisodios.size.height);
    
    NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    cells = [NSMutableArray array];
    
    sections = [self crearSectionsSeleccion];
    self.tableViewSeleccion = [[CustomTableViewController alloc] initWithFrame:frameTableViewSeleccion style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewSeleccion.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableViewSeleccion.layer.borderWidth = 0;
    self.tableViewSeleccion.bounces = YES;
    self.tableViewSeleccion.layer.borderColor = [[UIColor grayColor] CGColor];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    self.viewSeleccion = [[UIView alloc] initWithFrame:frameViewSeleccion];
    self.viewSeleccion.backgroundColor = [UIColor whiteColor];
    self.viewSeleccion.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.viewSeleccion.alpha = 0.0;
    
    sections = [NSMutableArray array];
    cells = [NSMutableArray array];
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    self.tableViewEpisodios = [[CustomTableViewController alloc] initWithFrame:frameTableViewEpisodios style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewEpisodios.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableViewEpisodios.layer.borderColor = [[UIColor grayColor] CGColor];
    
    self.viewEpisodios = [[UIView alloc] initWithFrame:frameViewEpisodios];
    self.viewEpisodios.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.viewEpisodios.layer.shadowOffset = CGSizeMake(-3,5);
    self.viewEpisodios.layer.shadowRadius = 3;
    self.viewEpisodios.layer.shadowOpacity = 0.3;
    self.viewEpisodios.backgroundColor = [UIColor whiteColor];
    self.viewEpisodios.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.viewEpisodios.alpha = 0.0;
    
    [self.viewSeleccion addSubview:self.tableViewSeleccion];
    [self.view addSubview:self.self.viewSeleccion];
    [self.viewEpisodios addSubview:self.tableViewEpisodios];
    [self.view addSubview:self.viewEpisodios];
    [self.view addSubview:self.labelSeriesPendientes];
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        /*self.imagenPerfil.alpha = 1.0;
         self.labelNombreUsuario.alpha = 1.0;
         self.labelNombreUsuarioCompleto.alpha = 1.0;
         self.labelNombreUsuarioAlta.alpha = 1.0;*/
        self.viewSeleccion.alpha = 1.0;
    } completion:^(BOOL finished){
        
    }];
}

- (NSMutableArray *) crearSectionsSeleccion {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    CustomCellPerfilSeleccionSeriesPendientes *customCellPerfilSeleccionSeriesPendiente = [[CustomCellPerfilSeleccionSeriesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCION cellText:@"Series pendientes" selectionType:YES customCell:customCellPerfilSeleccionSeriesPendiente];
    //[customCellPerfilSeleccionSeriesPendiente customSelect];
    [cells addObject:customCellPerfilSeleccionSeriesPendiente];
    
    CustomCellPerfilSeleccionPeliculasPendientes *customCellPerfilSeleccionPeliculasPendientes = [[CustomCellPerfilSeleccionPeliculasPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCION cellText:@"Películas pendientes" selectionType:YES customCell:customCellPerfilSeleccionPeliculasPendientes];
    [cells addObject:customCellPerfilSeleccionPeliculasPendientes];
    
    CustomCellPerfilSeleccionDocumentalesPendientes *customCellPerfilSeleccionDocumentalesPendientes = [[CustomCellPerfilSeleccionDocumentalesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCION cellText:@"Documentales pendientes" selectionType:YES customCell:customCellPerfilSeleccionDocumentalesPendientes];
    [cells addObject:customCellPerfilSeleccionDocumentalesPendientes];
    
    CustomCellPerfilSeleccionTVShowsPendientes *customCellPerfilSeleccionTVShowsPendientes = [[CustomCellPerfilSeleccionTVShowsPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCION cellText:@"TVShows pendientes" selectionType:YES customCell:customCellPerfilSeleccionTVShowsPendientes];
    [cells addObject:customCellPerfilSeleccionTVShowsPendientes];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    return sections;
}

@end















/************************************************************************************************************************
 ************************************************************************************************************************
 ****************************** PerfilViewControllerIphone **************************************************************
 ************************************************************************************************************************
 ************************************************************************************************************************/


@implementation PerfilViewControllerIphone

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) loadData {
    CGSize screenSize = [ScreenSizeManager currentSize];
    CGFloat screenHeight = screenSize.height;
    //NSLog(@"adios %.2f",self.navigationController.tabBarController.tabBar.frame.size.height);
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    viewFrame.size.height = screenHeight - self.navigationController.navigationBar.frame.size.height - self.navigationController.tabBarController.tabBar.frame.size.height;
    
    self.view.frame = viewFrame;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"BarButtonLogout", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(handlerLogout)];
    
    [self loadImage];
    [self loadUserInformation];
    [self loadEpisodes];
    
    [super loadData]; // Llamamos al loadData del padre
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
}

-(void) loadImage {
    self.imagenPerfil = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
    
    // Editamos la apariencia de la foto de perfil
    self.imagenPerfil.layer.borderWidth = 0.5;
    self.imagenPerfil.layer.borderColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0].CGColor;
    self.imagenPerfil.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.imagenPerfil.layer.shadowOffset = CGSizeMake(3,3);
    self.imagenPerfil.layer.shadowRadius = 2;
    self.imagenPerfil.layer.shadowOpacity = 0.6;
    
    [self.view addSubview:self.imagenPerfil];
}

-(void) loadUserInformation {
    self.labelNombreUsuario = [[UILabel alloc] init];
    self.labelNombreUsuario.font = [UIFont boldSystemFontOfSize:18];
    //self.labelNombreUsuario.textColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    [self.view addSubview:self.labelNombreUsuario];
    
    self.labelNombreUsuarioCompleto = [[UILabel alloc] init];
    self.labelNombreUsuarioCompleto.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.labelNombreUsuarioCompleto];
    
    self.labelNombreUsuarioAlta = [[UILabel alloc] init];
    self.labelNombreUsuarioAlta.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.labelNombreUsuarioAlta];
}

-(void) loadEpisodes {
    self.labelSeriesPendientes = [[UILabel alloc] init];
    self.labelSeriesPendientes.font = [UIFont systemFontOfSize:18];
    
    
    NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells;
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenHeight = screenRect.size.height;
    
    //section 1
    cells = [NSMutableArray array];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    //NSLog(@"%.2f",self.view.frame.size.height);
    
    // Creamos el tableView y lo anadimos a la subvista
    CGRect tableViewFrame = self.view.frame;
    //tableViewFrame.origin = CGPointMake(0,self.imagenPerfil.frame.origin.y + self.imagenPerfil.frame.size.height + 15);
    //tableViewFrame.size.height = self.view.frame.size.height - tableViewFrame.origin.y;
    
    self.tableViewEpisodios = [[CustomTableViewController alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewEpisodios.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.tableViewEpisodios];
    [self.view addSubview:self.labelSeriesPendientes];
}

@end


