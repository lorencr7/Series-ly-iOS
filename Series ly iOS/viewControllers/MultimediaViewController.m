//
//  MultimediaViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MultimediaViewController.h"
#import "ConstantsCustomSplitViewController.h"
#import "TVFramework.h"
#import <QuartzCore/QuartzCore.h>
#import "PerfilViewController.h"
#import "User.h"
#import "ManejadorServicioWebSeriesly.h"
#import "UserCredentials.h"
#import "MediaElementUser.h"
#import "Poster.h"
#import "CustomCellSeriesListadoSeries.h"

@interface MultimediaViewController ()

@end

@implementation MultimediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation MultimediaViewControllerIpad


- (id)initWithTitle: (NSString *) title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}
/*- (id)initWithSourceInformation: (NSMutableArray *) sourceInformation Title: (NSString *) title {
    self = [super init];
    if (self) {
        self.sourceInformation = sourceInformation;
        self.title = title;
    }
    return self;
}*/

- (void) loadData {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {//Asignamos el tamaño al view dependiendo de nuestra orientacion
        self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
    } else {
        self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadListadoSeries];
    [self loadDetalleSeries];
    
    //Nos suscribimos a los cambios de orientacion del iPad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToLandscape:) name:@"RotateToLandscape" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToPortrait:) name:@"RotateToPortrait" object:nil];
    
    
    //Descargamos la informacion de usuario en background
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserInfo) object:nil];
    [thread start];
    
}
- (void) rotateToLandscape: (NSNotification *) notification {//llamado cuando se gira a landscape
    self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
}

- (void) rotateToPortrait: (NSNotification *) notification {//llamado cuando se gira a portrait
    self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
}

- (void) downloadUserInfo {
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    User * usuario = [PerfilViewController getUsuario];
    UserCredentials * userCredentials = [PerfilViewController getUserCredentials];
    if ([self.title isEqualToString:NSLocalizedString(@"TableViewSeriesCellText", nil)]) {
        usuario.seriesFollowing = [manejadorServicioWebSeriesly getUserFollowingSeriesWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
        self.sourceInformation = usuario.seriesFollowing;
    } else if ([self.title isEqualToString:NSLocalizedString(@"TableViewPeliculasCellText", nil)]){
        usuario.peliculasFollowing = [manejadorServicioWebSeriesly getUserFollowingMoviesWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
        self.sourceInformation = usuario.peliculasFollowing;
    } else if ([self.title isEqualToString:NSLocalizedString(@"TableViewProgramasCellText", nil)]){
        usuario.tvShowsFollowing = [manejadorServicioWebSeriesly getUserFollowingTvShowsWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
        self.sourceInformation = usuario.tvShowsFollowing;
    } else if ([self.title isEqualToString:NSLocalizedString(@"TableViewDocumentalesCellText", nil)]){
        usuario.documentalesFollowing = [manejadorServicioWebSeriesly getUserFollowingDocumentariesWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
        self.sourceInformation = usuario.documentalesFollowing;
    }
    [self configureUserInfo];
}

- (void) configureUserInfo {
    int anchoDiferente = 60;//diferencia de tamaño de los tableView
    
    CGRect frame;
    
    //Asignamos el frame al UIView que contiene el tableView de la izquierda
    frame = self.viewListadoSeries.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = self.view.frame.size.width/2 - anchoDiferente;
    frame.size.height = self.view.frame.size.height;
    self.viewListadoSeries.frame = frame;
    
    //asignamos el frame al UIView que contiene el tableView de la derecha
    frame = self.viewDetalleSeries.frame;
    frame.origin.x = self.viewListadoSeries.frame.origin.x + self.viewListadoSeries.frame.size.width;
    frame.origin.y = 0;
    frame.size.width = self.view.frame.size.width/2 + anchoDiferente;
    frame.size.height = self.view.frame.size.height;
    //self.viewCustomTableViewController.backgroundColor = [UIColor blueColor];
    self.viewDetalleSeries.frame = frame;
    
    //asignamos el frame al tableView de la izquierda
    frame = self.tableViewListadoSeries.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = self.viewListadoSeries.frame.size.width;
    frame.size.height = self.viewListadoSeries.frame.size.height;
    self.tableViewListadoSeries.frame = frame;
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.viewListadoSeries.alpha = 1.0;
        self.viewDetalleSeries.alpha = 1.0;
    } completion:^(BOOL finished){
        
    }];
    
    //Rellenamos el tableView de la derecha con los capitulos de series pendientes
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(fillTableViewListadoWithSource:) object:self.sourceInformation];
    [thread start];
    //[self fillTableViewFromSource:usuario.seriesPendientes];
    //Le decimos al tableView de la izquierda que su primera celda es la que ha sido pulsada (series pendientes)
    //[self.tableViewSeleccion selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(CustomCellSeriesListadoSeries *) createCellListadoSeriesWithMediaElementUserPending: (MediaElementUser *) mediaElementUser {
    UIView * backgroundView = [[UIView alloc] init];
    int altoCelda = 0;
    UIImageView * poster = [[UIImageView alloc] init];
    NSString * urlImagen = mediaElementUser.poster.large;
    if (urlImagen) {
        NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
        [arguments setObject:poster forKey:@"imageView"];
        [arguments setObject:urlImagen forKey:@"url"];
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureImageView:) object:arguments];
        [thread start];
    }
    
    UILabel * labelSerie = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 0)];
    labelSerie.text = [NSString stringWithFormat:@"%@",mediaElementUser.name];
    labelSerie.backgroundColor = [UIColor clearColor];
    labelSerie.numberOfLines = 2;
    labelSerie.font = [UIFont boldSystemFontOfSize:18];
    [labelSerie sizeToFit];
    
    int margen = 15;
    
    CGRect frame = poster.frame;
    frame.origin.x = margen;
    frame.origin.y = margen;
    frame.size.width = 87.5;
    frame.size.height = 130;
    
    poster.frame = frame;
    
    int separacionDelPoster = 25;
    
    frame = labelSerie.frame;
    frame.origin.y = poster.frame.origin.y + poster.frame.size.height/2 - labelSerie.frame.size.height/2;
    frame.origin.x = poster.frame.origin.x + poster.frame.size.width + separacionDelPoster;
    labelSerie.frame = frame;
    
    altoCelda = poster.frame.origin.y + poster.frame.size.height + margen;
    
    [backgroundView addSubview:poster];
    [backgroundView addSubview:labelSerie];
    
    
    CustomCellSeriesListadoSeries * customCellSeriesListadoSeries = [[CustomCellSeriesListadoSeries alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIALISTADOCAPITULOS(backgroundView, altoCelda) cellText:nil selectionType:YES customCell:customCellSeriesListadoSeries];
    return customCellSeriesListadoSeries;
}

-(void) fillTableViewListadoWithSource: (NSMutableArray *) source {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    //UILabel * labelHeader;
    //labelHeader = [[FabricaHeaderFooterSecciones getInstance] getNewTitleLabelWithTitle:@"Mis Series" appearance:HEADERELMUNDO2(0, 10, self.tableViewListadoSeries.frame.size.width, 22)];
    
    for (MediaElementUser * mediaElementUser in source) {
        [cells addObject:[self createCellListadoSeriesWithMediaElementUserPending:mediaElementUser]];
    }
    
    
    
    //sectionElement = [[SectionElement alloc] initWithHeightHeader:labelHeader.frame.size.height + 10 labelHeader:labelHeader heightFooter:0 labelFooter:nil cells:cells];
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    self.tableViewListadoSeries.section.sections = sections;
    [self.tableViewListadoSeries reloadData];
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

-(void) loadListadoSeries {
    NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    //section 1
    cells = [NSMutableArray array];
    
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    self.tableViewListadoSeries = [[CustomTableViewController alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewListadoSeries.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableViewListadoSeries.bounces = YES;
    
    self.viewListadoSeries = [[UIView alloc] init];
    self.viewListadoSeries.backgroundColor = [UIColor whiteColor];
    self.viewListadoSeries.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.viewListadoSeries.alpha = 0.0;
    
    [self.viewListadoSeries addSubview:self.tableViewListadoSeries];
    [self.view addSubview:self.viewListadoSeries];
}

-(void) loadDetalleSeries {
    NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    //section 1
    cells = [NSMutableArray array];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    self.tableViewListadoCapitulos = [[CustomTableViewController alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewListadoCapitulos.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableViewListadoCapitulos.bounces = YES;
    
    self.viewDetalleSeries = [[UIView alloc] init];
    self.viewDetalleSeries.backgroundColor = [UIColor whiteColor];
    self.viewDetalleSeries.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.viewDetalleSeries.layer.shadowOffset = CGSizeMake(-3,5);
    self.viewDetalleSeries.layer.shadowRadius = 3;
    self.viewDetalleSeries.layer.shadowOpacity = 0.3;
    self.viewDetalleSeries.backgroundColor = [UIColor whiteColor];
    self.viewDetalleSeries.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.viewListadoSeries.alpha = 0.0;
    
    [self.viewDetalleSeries addSubview:self.tableViewListadoCapitulos];
    [self.view addSubview:self.viewDetalleSeries];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
}

@end


@implementation MultimediaViewControllerIphone

@end
