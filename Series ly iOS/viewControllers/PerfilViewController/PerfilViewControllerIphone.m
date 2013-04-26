//
//  PerfilViewControllerIphone.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 26/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "PerfilViewControllerIphone.h"
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
#import "UserInfo.h"

@interface PerfilViewControllerIphone ()

@end

@implementation PerfilViewControllerIphone

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    int altoNavigationBar;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        altoNavigationBar = 32;
    } else {
        altoNavigationBar = 44;
    }
    
    CGSize screenSize = [ScreenSizeManager currentSize];
    //NSLog(@"adios %.2f",self.navigationController.tabBarController.tabBar.frame.size.height);
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    viewFrame.origin.x = 0;
    viewFrame.size.height = screenSize.height - altoNavigationBar;
    viewFrame.size.width = screenSize.width;
    
    self.view.frame = viewFrame;
    
    [self loadUserInfo];
    [self loadEpisodes];//Inicializamos los tableViews que controlan los episodios pendientes
    
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserInfo) object:nil];
    [thread start];
    //NSThread * thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserPendingInfo) object:nil];
    //[thread2 start];
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
    self.viewPerfil.backgroundColor = [UIColor clearColor];
    self.viewPerfil.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.viewPerfil.alpha = 0.0;
    [self.view addSubview:self.viewPerfil];
    
    [self loadImage];//Inicializamos la imagen del usuario
    [self loadUserInformation];//Inicializamos los labels de la informacion de usuario
}

-(void) loadImage {
    //Asignamos el frame a la imagen de perfil. Las medidas no cambian (100x105)
    self.imagenPerfil = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 105)];
    
    // Editamos la apariencia de la foto de perfil
    self.imagenPerfil.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.imagenPerfil.layer.shadowOffset = CGSizeMake(3,3);
    self.imagenPerfil.layer.shadowRadius = 2;
    self.imagenPerfil.layer.shadowOpacity = 0.6;
    
    
    [self.viewPerfil addSubview:self.imagenPerfil];
}

-(void) loadUserInformation {
    self.labelNombreUsuario = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 10, 15, 0, 22)];
    self.labelNombreUsuario.font = [UIFont boldSystemFontOfSize:18];
    self.labelNombreUsuario.backgroundColor = [UIColor clearColor];
    [self.viewPerfil addSubview:self.labelNombreUsuario];
    
    self.labelNombreUsuarioCompleto = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 10, self.labelNombreUsuario.frame.origin.y + self.labelNombreUsuario.frame.size.height + 5, 0, 22)];
    self.labelNombreUsuarioCompleto.font = [UIFont systemFontOfSize:14];
    self.labelNombreUsuarioCompleto.backgroundColor = [UIColor clearColor];
    [self.viewPerfil addSubview:self.labelNombreUsuarioCompleto];
    
    self.labelNombreUsuarioAlta = [[UILabel alloc] initWithFrame:CGRectMake(self.imagenPerfil.frame.origin.x + self.imagenPerfil.frame.size.width + 10, self.labelNombreUsuarioCompleto.frame.origin.y + self.labelNombreUsuarioCompleto.frame.size.height + 5, 0, 22)];
    self.labelNombreUsuarioAlta.font = [UIFont systemFontOfSize:14];
    self.labelNombreUsuarioAlta.backgroundColor = [UIColor clearColor];
    [self.viewPerfil addSubview:self.labelNombreUsuarioAlta];
}

-(void) loadEpisodes {

    CGRect frameViewSeleccion = CGRectMake(0,
                                           self.viewPerfil.frame.origin.y + self.viewPerfil.frame.size.height,
                                           self.view.frame.size.width,
                                           self.view.frame.size.height - (self.viewPerfil.frame.origin.y + self.viewPerfil.frame.size.height));
    CGRect frameTableViewSeleccion = CGRectMake(0,
                                                0,
                                                frameViewSeleccion.size.width,
                                                frameViewSeleccion.size.height);
    
    NSMutableArray *sections;
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    cells = [NSMutableArray array];
    
    sections = [self crearSectionsSeleccion];
    self.tableViewSeleccion = [[CustomTableViewController alloc] initWithFrame:frameTableViewSeleccion style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewSeleccion.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableViewSeleccion.layer.borderWidth = 0;
    self.tableViewSeleccion.bounces = YES;
    self.tableViewSeleccion.layer.borderColor = [[UIColor grayColor] CGColor];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    self.viewSeleccion = [[UIView alloc] initWithFrame:frameViewSeleccion];
    self.viewSeleccion.backgroundColor = [UIColor clearColor];
    self.viewSeleccion.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.viewSeleccion.alpha = 0.0;
    
    
    [self.viewSeleccion addSubview:self.tableViewSeleccion];
    [self.view addSubview:self.self.viewSeleccion];
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.viewSeleccion.alpha = 1.0;
    } completion:^(BOOL finished){
        
    }];
}

#define UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor whiteColor]
#define SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]
#define TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(100/255.0) alpha:1]
#define TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor whiteColor]
#define UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE [UIFont systemFontOfSize:18.0]
#define SELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE [UIFont systemFontOfSize:18.0]
#define BORDERCOLORPERFILSELECCIONIPHONE [UIColor whiteColor]
#define BORDERWIDTHPERFILSELECCIONIPHONE 0.8
#define CORNERRADIUSPERFILSELECCIONIPHONE 0
#define TEXTALIGNMENTPERFILSELECCIONIPHONE NSTextAlignmentLeft
#define ACCESORYTYPEPERFILSELECCIONIPHONE UITableViewCellAccessoryDisclosureIndicator
#define LINEBREAKMODEPERFILSELECCIONIPHONE NSLineBreakByWordWrapping
#define NUMBEROFLINESPERFILSELECCIONIPHONE 0
#define ACCESORYVIEWPERFILSELECCIONIPHONE nil
#define HEIGHTCELLPERFILSELECCIONIPHONE 68

#define APARIENCIAPERFILSELECCIONIPHONE [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE selectedColor:SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE unselectedTextFont:UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE selectedTextFont:SELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE borderColor:BORDERCOLORPERFILSELECCIONIPHONE borderWidth:BORDERWIDTHPERFILSELECCIONIPHONE cornerRadius:CORNERRADIUSPERFILSELECCIONIPHONE textAlignment:TEXTALIGNMENTPERFILSELECCIONIPHONE accesoryType:ACCESORYTYPEPERFILSELECCIONIPHONE lineBreakMode:LINEBREAKMODEPERFILSELECCIONIPHONE numberOfLines:NUMBEROFLINESPERFILSELECCIONIPHONE accesoryView:ACCESORYVIEWPERFILSELECCIONIPHONE heightCell:HEIGHTCELLPERFILSELECCIONIPHONE]

- (NSMutableArray *) crearSectionsSeleccion {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    CustomCellPerfilSeleccionSeriesPendientes *customCellPerfilSeleccionSeriesPendiente = [[CustomCellPerfilSeleccionSeriesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPHONE cellText:@"Series pendientes" selectionType:YES customCell:customCellPerfilSeleccionSeriesPendiente];
    //[customCellPerfilSeleccionSeriesPendiente customSelect];
    [cells addObject:customCellPerfilSeleccionSeriesPendiente];
    
    CustomCellPerfilSeleccionPeliculasPendientes *customCellPerfilSeleccionPeliculasPendientes = [[CustomCellPerfilSeleccionPeliculasPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPHONE cellText:@"Películas pendientes" selectionType:YES customCell:customCellPerfilSeleccionPeliculasPendientes];
    [cells addObject:customCellPerfilSeleccionPeliculasPendientes];
    
    CustomCellPerfilSeleccionDocumentalesPendientes *customCellPerfilSeleccionDocumentalesPendientes = [[CustomCellPerfilSeleccionDocumentalesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPHONE cellText:@"Documentales pendientes" selectionType:YES customCell:customCellPerfilSeleccionDocumentalesPendientes];
    [cells addObject:customCellPerfilSeleccionDocumentalesPendientes];
    
    CustomCellPerfilSeleccionTVShowsPendientes *customCellPerfilSeleccionTVShowsPendientes = [[CustomCellPerfilSeleccionTVShowsPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPHONE cellText:@"TVShows pendientes" selectionType:YES customCell:customCellPerfilSeleccionTVShowsPendientes];
    [cells addObject:customCellPerfilSeleccionTVShowsPendientes];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    return sections;
}

@end
