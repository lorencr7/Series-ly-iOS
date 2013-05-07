//
//  ListadoElementsSiguiendoViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ListadoElementsSiguiendoViewController.h"
#import "TVFramework.h"
#import "ManejadorServicioWebSeriesly.h"
#import "User.h"
#import "UserCredentials.h"
#import <QuartzCore/QuartzCore.h>
#import "MediaElementUser.h"
#import "CustomCellSeriesListadoSeries.h"
#import "Poster.h"
#import "ASIHTTPRequest.h"

@interface ListadoElementsSiguiendoViewController ()

@end

@implementation ListadoElementsSiguiendoViewController

- (id)initWithFrame: (CGRect) frame SourceData: (TipoSourceDataSiguiendo) tipoSourceData{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.tipoSourceData = tipoSourceData;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.frame = self.frame;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self iniciarTableViewMultimedia];
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserInfo) object:nil];
    [thread start];
}

-(void) iniciarTableViewMultimedia {
    NSMutableArray *sections;
    SectionElement *sectionElement;
    NSMutableArray *cells;
    CGRect frameTableViewEpisodios = CGRectMake(0,
                                                0,
                                                self.view.frame.size.width,
                                                self.view.frame.size.height);
    sections = [NSMutableArray array];
    cells = [NSMutableArray array];
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    self.tableViewMultimedia = [[CustomTableViewController alloc] initWithFrame:frameTableViewEpisodios style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewMultimedia.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //self.tableViewEpisodios.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:self.tableViewMultimedia];
}

- (void) downloadUserInfo {
    
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    //User * usuario = [PerfilViewController getUsuario];
    //UserCredentials * userCredentials = [PerfilViewController getUserCredentials];
    User * usuario = [User getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    
    switch (self.tipoSourceData) {
        case SourceSeriesSiguiendo:
            usuario.seriesFollowing = [manejadorServicioWebSeriesly getUserFollowingSeriesWithRequest:nil ProgressView:nil AuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
            self.sourceData = usuario.seriesFollowing;
            break;
        case SourcePeliculasSiguiendo:
            usuario.peliculasFollowing = [manejadorServicioWebSeriesly getUserFollowingMoviesWithRequest:nil ProgressView:nil AuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
            self.sourceData = usuario.peliculasFollowing;
            break;
        case SourceTVShowsSiguiendo:
            usuario.tvShowsFollowing = [manejadorServicioWebSeriesly getUserFollowingTvShowsWithRequest:nil ProgressView:nil AuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
            self.sourceData = usuario.tvShowsFollowing;
            break;
        case SourceDocumentalesSiguiendo:
            usuario.documentalesFollowing = [manejadorServicioWebSeriesly getUserFollowingDocumentariesWithRequest:nil ProgressView:nil AuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
            self.sourceData = usuario.documentalesFollowing;
            break;
            
        default:
            break;
    }
    if (!self.sourceData) {
        NSLog(@"error descargando la info de siguiendo del usuario");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ups" message:@"No se pudo descargar la información que sigues" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        [self fillTableViewInBackgroundFromSource:self.sourceData];
    }
    
}

-(void) fillTableViewInBackgroundFromSource:(NSMutableArray *)source {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    for (MediaElementUser * mediaElementUser in source) {
        [cells addObject:[self createCellListadoSeriesWithMediaElementUserPending:mediaElementUser]];
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    self.tableViewMultimedia.section.sections = sections;
    [self.tableViewMultimedia reloadData];
}

#define SELECTEDCOLORAPARIENCIALISTADOSIGUIENDO [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIALISTADOSIGUIENDO nil
#define TEXTSELECTEDCOLORAPARIENCIALISTADOSIGUIENDO nil
#define UNSELECTEDFONTAPARIENCIALISTADOSIGUIENDO nil
#define SELECTEDFONTAPARIENCIALISTADOSIGUIENDO nil
#define TEXTALIGNMENTLISTADOSIGUIENDO 0
#define ACCESORYTYPELISTADOSIGUIENDO UITableViewCellAccessoryNone
#define LINEBREAKMODELISTADOSIGUIENDO 0
#define NUMBEROFLINESLISTADOSIGUIENDO 0
#define ACCESORYVIEWLISTADOSIGUIENDO nil
//#define CUSTOMHEIGHTCELLLISTADOSIGUIENDO 80

#define APARIENCIALISTADOSIGUIENDO(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIALISTADOSIGUIENDO unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIALISTADOSIGUIENDO selectedTextColor:TEXTSELECTEDCOLORAPARIENCIALISTADOSIGUIENDO unselectedTextFont:UNSELECTEDFONTAPARIENCIALISTADOSIGUIENDO selectedTextFont:SELECTEDFONTAPARIENCIALISTADOSIGUIENDO textAlignment:TEXTALIGNMENTLISTADOSIGUIENDO accesoryType:ACCESORYTYPELISTADOSIGUIENDO lineBreakMode:LINEBREAKMODELISTADOSIGUIENDO numberOfLines:NUMBEROFLINESLISTADOSIGUIENDO accesoryView:ACCESORYVIEWLISTADOSIGUIENDO backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]

-(CustomCellSeriesListadoSeries *) createCellListadoSeriesWithMediaElementUserPending: (MediaElementUser *) mediaElementUser {
    
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       300,
                                                                       0)];
    int altoCelda = 0;
    int margenX = 5;
    int margenY = 10;
    int separacionDelPoster = 10;
    UIImageView * poster = [[UIImageView alloc] initWithFrame:CGRectMake(margenX, margenY, 87.5, 130)];
    poster.layer.cornerRadius = 6.0f;
    poster.clipsToBounds = YES;
    NSString * urlImagen = mediaElementUser.poster.large;
    if (urlImagen) {
        NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
        [arguments setObject:poster forKey:@"imageView"];
        [arguments setObject:urlImagen forKey:@"url"];
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureImageView:) object:arguments];
        [thread start];
    }
    
    
    UILabel * labelSerie = [[UILabel alloc] initWithFrame:
                            CGRectMake(poster.frame.origin.x + poster.frame.size.width + separacionDelPoster,
                                       poster.frame.origin.y + poster.frame.size.height/2 - 22/2 - 30,
                                       backgroundView.frame.size.width - poster.frame.size.width - separacionDelPoster - 35,
                                       0)];
    //
    
    labelSerie.text = [NSString stringWithFormat:@"%@",mediaElementUser.name];
    labelSerie.backgroundColor = [UIColor clearColor];
    labelSerie.font = [UIFont boldSystemFontOfSize:18];
    labelSerie.numberOfLines = 3;
    //
    [labelSerie sizeToFit];
    labelSerie.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    
    altoCelda = poster.frame.origin.y + poster.frame.size.height + margenY;
    
    [backgroundView addSubview:poster];
    [backgroundView addSubview:labelSerie];
    
    
    CustomCellSeriesListadoSeries * customCellSeriesListadoSeries = [[CustomCellSeriesListadoSeries alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIALISTADOSIGUIENDO(backgroundView, altoCelda) cellText:nil selectionType:YES customCell:customCellSeriesListadoSeries];
    return customCellSeriesListadoSeries;
    
    /*UIView * backgroundView = [[UIView alloc] init];
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
     return customCellSeriesListadoSeries;*/
}

//Este metodo se descarga una imagen de internet y la asigna a su imageView correspondiente
-(void) configureImageView: (NSMutableDictionary *) arguments {
    UIImageView * imageView = [arguments objectForKey:@"imageView"];
    NSString * url = [arguments objectForKey:@"url"];
    UIImage * imagen;
    NSURL * imageURL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:imageURL];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        NSData * imageData = [request responseData];
        imagen = [UIImage imageWithData:imageData];
        imageView.image = imagen;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
