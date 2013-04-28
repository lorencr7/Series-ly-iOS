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
#import "ListadoCapitulosPendientesViewController.h"
#import "DatosPerfilViewController.h"

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
    
    //NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserInfo) object:nil];
    //[thread start];
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

-(void) loadUserInfo {
    CGRect datosPerfilFrame = CGRectMake(0,
                                         0,
                                         self.view.frame.size.width,
                                         120);
    self.datosPerfilViewController = [[DatosPerfilViewController alloc] initWithFrame:datosPerfilFrame];
    [self.view addSubview:self.datosPerfilViewController.view];
    
}


-(void) loadEpisodes {
    int anchoDiferente = 60;//diferencia de tamaño de los tableView
    
    CGRect frameViewSeleccion = CGRectMake(0,
                                           self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height,
                                           self.view.frame.size.width/2 - anchoDiferente,
                                           self.view.frame.size.height - (self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height));
    
    CGRect frameTableViewSeleccion = CGRectMake(0,
                                                0,
                                                frameViewSeleccion.size.width,
                                                frameViewSeleccion.size.height);
    
    CGRect frameViewEpisodios = CGRectMake(frameViewSeleccion.origin.x + frameViewSeleccion.size.width,
                                           self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height,
                                           self.view.frame.size.width/2 + anchoDiferente,
                                           self.view.frame.size.height - (self.datosPerfilViewController.view.frame.origin.y + self.datosPerfilViewController.view.frame.size.height));
    
    NSMutableArray *sections;
    NSMutableArray *cells;
    
    cells = [NSMutableArray array];
    
    sections = [self crearSectionsSeleccion];
    self.tableViewSeleccion = [[CustomTableViewController alloc] initWithFrame:frameTableViewSeleccion style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewSeleccion.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableViewSeleccion.layer.borderWidth = 0;
    self.tableViewSeleccion.bounces = YES;
    self.tableViewSeleccion.layer.borderColor = [[UIColor grayColor] CGColor];
    
    SectionElement * secionElement = [self.tableViewSeleccion.section.sections objectAtIndex:0];
    CustomCellPerfilSeleccionSeriesPendientes * customCellPerfilSeleccionSeriesPendiente = [secionElement.cells objectAtIndex:0];
    [customCellPerfilSeleccionSeriesPendiente customSelect];
    
    [self.tableViewSeleccion selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    self.viewSeleccion = [[UIView alloc] initWithFrame:frameViewSeleccion];
    self.viewSeleccion.backgroundColor = [UIColor whiteColor];
    self.viewSeleccion.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.viewSeleccion.alpha = 0.0;
    
    self.listadoCapitulosPendientesViewController = [[ListadoCapitulosPendientesViewController alloc] initWithFrame:frameViewEpisodios SourceData:SourceSeriesPendientes];
    
    [self.viewSeleccion addSubview:self.tableViewSeleccion];
    [self.view addSubview:self.self.viewSeleccion];
    
    [self.view addSubview:self.listadoCapitulosPendientesViewController.view];
    
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

