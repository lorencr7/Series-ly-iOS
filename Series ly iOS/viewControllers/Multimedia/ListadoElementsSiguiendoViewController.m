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
    [self iniciarActivityIndicator];
    [self.activityIndicatorView startAnimating];
    
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
    self.customTableView = [[CustomTableViewController alloc] initWithFrame:frameTableViewEpisodios style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.customTableView.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self iniciarRefreshControl];
    //[self.customTableView addSubview:self.refreshControl];
    
    [self.view addSubview:self.tableViewController.view];
}

-(void) refresh {
    [self downloadUserInfo];
    [self performSelectorOnMainThread:@selector(stopRefreshAnimation) withObject:nil waitUntilDone:NO];
}

- (void) downloadUserInfo {
    
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    //User * usuario = [PerfilViewController getUsuario];
    //UserCredentials * userCredentials = [PerfilViewController getUserCredentials];
    
    User * usuario = [User getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    BOOL hayNuevosDatos = NO;
    
    
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
    
    if (self.lastSourceData) {
        if (![self.lastSourceData isEqualToArray:self.sourceData]) {
            hayNuevosDatos = YES;
        }
    } else {
        hayNuevosDatos = YES;
    }
    
    if (self.sourceData ) {
        if (hayNuevosDatos) {
            self.lastSourceData = self.sourceData;
            [self fillTableViewInBackgroundFromSource:self.sourceData];
        }
    } else {
        NSLog(@"error descargando la info de siguiendo del usuario");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ups" message:@"No se pudo descargar la información que sigues" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    
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
    self.customTableView.section.sections = sections;
    [self.customTableView reloadData];
}

#define SELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPAD [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPAD nil
#define TEXTSELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPAD nil
#define UNSELECTEDFONTAPARIENCIALISTADOSIGUIENDOIPAD nil
#define SELECTEDFONTAPARIENCIALISTADOSIGUIENDOIPAD nil
#define TEXTALIGNMENTLISTADOSIGUIENDOIPAD 0
#define ACCESORYTYPELISTADOSIGUIENDOIPAD UITableViewCellAccessoryNone
#define LINEBREAKMODELISTADOSIGUIENDOIPAD 0
#define NUMBEROFLINESLISTADOSIGUIENDOIPAD 0
#define ACCESORYVIEWLISTADOSIGUIENDOIPAD nil
//#define CUSTOMHEIGHTCELLLISTADOSIGUIENDOIPAD 80

#define APARIENCIALISTADOSIGUIENDOIPAD(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPAD unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPAD selectedTextColor:TEXTSELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPAD unselectedTextFont:UNSELECTEDFONTAPARIENCIALISTADOSIGUIENDOIPAD selectedTextFont:SELECTEDFONTAPARIENCIALISTADOSIGUIENDOIPAD textAlignment:TEXTALIGNMENTLISTADOSIGUIENDOIPAD accesoryType:ACCESORYTYPELISTADOSIGUIENDOIPAD lineBreakMode:LINEBREAKMODELISTADOSIGUIENDOIPAD numberOfLines:NUMBEROFLINESLISTADOSIGUIENDOIPAD accesoryView:ACCESORYVIEWLISTADOSIGUIENDOIPAD backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]

#define SELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPHONE [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPHONE nil
#define TEXTSELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPHONE nil
#define UNSELECTEDFONTAPARIENCIALISTADOSIGUIENDOIPHONE nil
#define SELECTEDFONTAPARIENCIALISTADOSIGUIENDOIPHONE nil
#define TEXTALIGNMENTLISTADOSIGUIENDOIPHONE 0
#define ACCESORYTYPELISTADOSIGUIENDOIPHONE UITableViewCellAccessoryDisclosureIndicator
#define LINEBREAKMODELISTADOSIGUIENDOIPHONE 0
#define NUMBEROFLINESLISTADOSIGUIENDOIPHONE 0
#define ACCESORYVIEWLISTADOSIGUIENDOIPHONE nil
//#define CUSTOMHEIGHTCELLLISTADOSIGUIENDOIPHONE 80

#define APARIENCIALISTADOSIGUIENDOIPHONE(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPHONE unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPHONE selectedTextColor:TEXTSELECTEDCOLORAPARIENCIALISTADOSIGUIENDOIPHONE unselectedTextFont:UNSELECTEDFONTAPARIENCIALISTADOSIGUIENDOIPHONE selectedTextFont:SELECTEDFONTAPARIENCIALISTADOSIGUIENDOIPHONE textAlignment:TEXTALIGNMENTLISTADOSIGUIENDOIPHONE accesoryType:ACCESORYTYPELISTADOSIGUIENDOIPHONE lineBreakMode:LINEBREAKMODELISTADOSIGUIENDOIPHONE numberOfLines:NUMBEROFLINESLISTADOSIGUIENDOIPHONE accesoryView:ACCESORYVIEWLISTADOSIGUIENDOIPHONE backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]

-(CustomCellAppearance *) getAppearance: (UIView *) backgroundView AltoCelda: (int) altoCelda {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return APARIENCIALISTADOSIGUIENDOIPHONE(backgroundView, altoCelda);
        
    } else {
        return APARIENCIALISTADOSIGUIENDOIPAD(backgroundView, altoCelda);
    }
    
}

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
    
    CGRect labelSerieFrame = labelSerie.frame;
    labelSerieFrame.origin.y = (poster.frame.origin.y + poster.frame.size.height/2) - labelSerieFrame.size.height/2;
    labelSerie.frame = labelSerieFrame;
    
    
    
    altoCelda = poster.frame.origin.y + poster.frame.size.height + margenY;
    
    [backgroundView addSubview:poster];
    [backgroundView addSubview:labelSerie];
    
    
    CustomCellSeriesListadoSeries * customCellSeriesListadoSeries = [[CustomCellSeriesListadoSeries alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance:backgroundView AltoCelda:altoCelda] cellText:nil selectionType:YES customCell:customCellSeriesListadoSeries];
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
