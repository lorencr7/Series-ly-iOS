//
//  PerfilViewControllerIpad.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 26/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "PerfilViewControllerIpad.h"
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

@interface PerfilViewControllerIpad ()

@end


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
        self.viewPerfil.alpha = 1.0;
        self.viewSeleccion.alpha = 1.0;
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
    int anchoDiferente = 60;//diferencia de tamaño de los tableView
    
    CGRect frameViewSeleccion = CGRectMake(0,
                                           self.viewPerfil.frame.origin.y + self.viewPerfil.frame.size.height,
                                           self.view.frame.size.width/2 - anchoDiferente,
                                           self.view.frame.size.height - (self.viewPerfil.frame.origin.y + self.viewPerfil.frame.size.height));
    
    CGRect frameTableViewSeleccion = CGRectMake(0,
                                                0,
                                                frameViewSeleccion.size.width,
                                                frameViewSeleccion.size.height);
    
    CGRect frameViewEpisodios = CGRectMake(frameViewSeleccion.origin.x + frameViewSeleccion.size.width + self.view.frame.size.width/6,
                                           self.viewPerfil.frame.origin.y + self.viewPerfil.frame.size.height,
                                           self.view.frame.size.width/2 + anchoDiferente,
                                           self.view.frame.size.height - (self.viewPerfil.frame.origin.y + self.viewPerfil.frame.size.height));
    
    CGRect frameTableViewEpisodios = CGRectMake(0,
                                                0,
                                                frameViewEpisodios.size.width,
                                                frameViewEpisodios.size.height);
    
    NSMutableArray *sections;
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
        self.viewSeleccion.alpha = 1.0;
    } completion:^(BOOL finished){
        
    }];
}

#define UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor whiteColor]
#define SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]
#define TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(100/255.0) alpha:1]
#define TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor whiteColor]
#define UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD [UIFont systemFontOfSize:20.0]
#define SELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD [UIFont systemFontOfSize:20.0]
#define BORDERCOLORPERFILSELECCIONIPAD [UIColor whiteColor]
#define BORDERWIDTHPERFILSELECCIONIPAD 0.8
#define CORNERRADIUSPERFILSELECCIONIPAD 0
#define TEXTALIGNMENTPERFILSELECCIONIPAD NSTextAlignmentLeft
#define ACCESORYTYPEPERFILSELECCIONIPAD UITableViewCellAccessoryDisclosureIndicator
#define LINEBREAKMODEPERFILSELECCIONIPAD NSLineBreakByWordWrapping
#define NUMBEROFLINESPERFILSELECCIONIPAD 0
#define ACCESORYVIEWPERFILSELECCIONIPAD nil
#define HEIGHTCELLPERFILSELECCIONIPAD 90

#define APARIENCIAPERFILSELECCIONIPAD [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD selectedColor:SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD unselectedTextFont:UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD selectedTextFont:SELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD borderColor:BORDERCOLORPERFILSELECCIONIPAD borderWidth:BORDERWIDTHPERFILSELECCIONIPAD cornerRadius:CORNERRADIUSPERFILSELECCIONIPAD textAlignment:TEXTALIGNMENTPERFILSELECCIONIPAD accesoryType:ACCESORYTYPEPERFILSELECCIONIPAD lineBreakMode:LINEBREAKMODEPERFILSELECCIONIPAD numberOfLines:NUMBEROFLINESPERFILSELECCIONIPAD accesoryView:ACCESORYVIEWPERFILSELECCIONIPAD heightCell:HEIGHTCELLPERFILSELECCIONIPAD]

- (NSMutableArray *) crearSectionsSeleccion {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    CustomCellPerfilSeleccionSeriesPendientes *customCellPerfilSeleccionSeriesPendiente = [[CustomCellPerfilSeleccionSeriesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPAD cellText:@"Series pendientes" selectionType:YES customCell:customCellPerfilSeleccionSeriesPendiente];
    //[customCellPerfilSeleccionSeriesPendiente customSelect];
    [cells addObject:customCellPerfilSeleccionSeriesPendiente];
    
    CustomCellPerfilSeleccionPeliculasPendientes *customCellPerfilSeleccionPeliculasPendientes = [[CustomCellPerfilSeleccionPeliculasPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPAD cellText:@"Películas pendientes" selectionType:YES customCell:customCellPerfilSeleccionPeliculasPendientes];
    [cells addObject:customCellPerfilSeleccionPeliculasPendientes];
    
    CustomCellPerfilSeleccionDocumentalesPendientes *customCellPerfilSeleccionDocumentalesPendientes = [[CustomCellPerfilSeleccionDocumentalesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPAD cellText:@"Documentales pendientes" selectionType:YES customCell:customCellPerfilSeleccionDocumentalesPendientes];
    [cells addObject:customCellPerfilSeleccionDocumentalesPendientes];
    
    CustomCellPerfilSeleccionTVShowsPendientes *customCellPerfilSeleccionTVShowsPendientes = [[CustomCellPerfilSeleccionTVShowsPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPAD cellText:@"TVShows pendientes" selectionType:YES customCell:customCellPerfilSeleccionTVShowsPendientes];
    [cells addObject:customCellPerfilSeleccionTVShowsPendientes];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    return sections;
}

@end

