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

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];

    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserInfo) object:nil];
    [thread start];
}


-(void) refresh {
    [self downloadUserInfo];
    [self performSelectorOnMainThread:@selector(stopRefreshAnimation) withObject:nil waitUntilDone:NO];
}

- (void) downloadUserInfo {

    
    
    [self selectTypeOfData];
    
    BOOL hayNuevaInfo = [self hayNuevaInfo];
    
    if (self.sourceData ) {
        if (hayNuevaInfo) {
            self.lastSourceData = self.sourceData;
            [self fillTableViewInBackgroundFromSource:self.sourceData];
        }
    } else {
        NSLog(@"error descargando la info de siguiendo del usuario");
        //UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ups" message:@"No se pudo descargar la información que sigues" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[alertView show];
    }
}

-(void) selectTypeOfData {
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
}



-(void) fillTableViewInBackgroundFromSource:(NSMutableArray *)source {
    NSMutableArray * sections = [self createSectionsFromSource:source];
    [self stopActivityIndicator];
    [self reloadTableViewWithSections:sections];
}

-(NSMutableArray *) createSectionsFromSource:(NSMutableArray *)source {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    
    for (MediaElementUser * mediaElementUser in source) {
        [cells addObject:[self createCellListadoSeriesWithMediaElementUser:mediaElementUser]];
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    return sections;
}


-(CustomCellAppearance *) getAppearance: (UIView *) backgroundView AltoCelda: (int) altoCelda {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return APARIENCIALISTADOSIGUIENDOIPHONE(backgroundView, altoCelda);
        
    } else {
        return APARIENCIALISTADOSIGUIENDOIPAD(backgroundView, altoCelda);
    }
    
}

-(CustomCellSeriesListadoSeries *) createCellListadoSeriesWithMediaElementUser: (MediaElementUser *) mediaElementUser {
    
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
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
