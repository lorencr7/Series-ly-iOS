//
//  ListadoCapitulosPendientesViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ListadoCapitulosPendientesViewController.h"
#import "TVFramework.h"
#import "ManejadorServicioWebSeriesly.h"
#import "User.h"
#import "UserCredentials.h"
#import "CustomCellPerfilListadoCapitulos.h"
#import <QuartzCore/QuartzCore.h>
#import "MediaElementUserPending.h"
#import "Pending.h"
#import "Poster.h"

@interface ListadoCapitulosPendientesViewController ()

@end

@implementation ListadoCapitulosPendientesViewController

#pragma mark -
#pragma mark init

- (id)initWithFrame: (CGRect) frame SourceData: (TipoSourceData) tipoSourceData{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.tipoSourceData = tipoSourceData;
    }
    return self;
}

#pragma mark -
#pragma mark UIViewControllerDelegate

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserPendingInfo) object:nil];
    [thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark downloadInfo

-(void) downloadUserPendingInfo {
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    User * usuario = [User getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    //Descargamos los capitulos de las series pendientes del usuario
    NSMutableDictionary * userPendingInfo = [manejadorServicioWebSeriesly getUserPendingInfoWithRequest:nil ProgressView:nil AuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
    if (!userPendingInfo) {
        NSLog(@"error descargando la info de pendientes del usuario");
        //UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ups" message:@"No se pudo descargar los capítulos pendientes" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[alertView show];
    } else {
        usuario.seriesPendientes = [userPendingInfo objectForKey:@"series"];
        usuario.peliculasPendientes = [userPendingInfo objectForKey:@"movies"];
        usuario.documentalesPendientes = [userPendingInfo objectForKey:@"documentaries"];
        usuario.tvShowsPendientes = [userPendingInfo objectForKey:@"tvshows"];
        //Rellenamos el tableView con los capitulos de series pendientes
    }
    
    [self selectTypeOfData];
    BOOL hayNuevaInfo = [self hayNuevaInfo];
    if (self.sourceData && hayNuevaInfo) {
        self.lastSourceData = self.sourceData;
        [self fillTableViewInBackgroundFromSource:self.sourceData];
    }
    
    
}

-(void) selectTypeOfData {
    User * usuario = [User getInstance];
    switch (self.tipoSourceData) {
        case SourceSeriesPendientes:
            self.sourceData = usuario.seriesPendientes;
            break;
        case SourcePeliculasPendientes:
            self.sourceData = usuario.peliculasPendientes;
            break;
        case SourceDocumentalesPendientes:
            self.sourceData = usuario.documentalesPendientes;
            break;
        case SourceTVShowsPendientes:
            self.sourceData = usuario.tvShowsPendientes;
            break;
            
        default:
            break;
    }
}

-(BOOL) hayNuevaInfo {
    if (self.lastSourceData) {
        if (![self.lastSourceData isEqualToArray:self.sourceData]) {
            return YES;
        }
    } else {
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark fillTableView

-(CustomCellAppearance *) getAppearance: (UIView *) backgroundView AltoCelda: (int) altoCelda {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return APARIENCIALISTADOCAPITULOSIPHONE(backgroundView, altoCelda);
        
    } else {
        return APARIENCIALISTADOCAPITULOSIPAD(backgroundView, altoCelda);
    }
}

//Este metodo crea una celda del tableView de la derecha a partir de un mediaElement
-(CustomCellPerfilListadoCapitulos *) createCellListadoCapitulosWithMediaElementUserPending: (MediaElementUserPending *) mediaElementUserPending {
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
    NSString * urlImagen = mediaElementUserPending.poster.large;
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
    
    labelSerie.text = [NSString stringWithFormat:@"%@",mediaElementUserPending.name];
    labelSerie.backgroundColor = [UIColor clearColor];
    labelSerie.font = [UIFont boldSystemFontOfSize:18];
    labelSerie.numberOfLines = 2;
    //
    [labelSerie sizeToFit];
    labelSerie.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    
    UILabel * labelEpisodio;
    if (mediaElementUserPending.pending.full) {
        labelEpisodio = [[UILabel alloc] initWithFrame:CGRectMake(poster.frame.origin.x + poster.frame.size.width + separacionDelPoster, 0, 0, 0)];
        labelEpisodio.text = [NSString stringWithFormat:@"%@",mediaElementUserPending.pending.full];
        labelEpisodio.backgroundColor = [UIColor clearColor];
        labelEpisodio.font = [UIFont systemFontOfSize:17];
        [labelEpisodio sizeToFit];
    }
    
    CGRect labelSerieFrame = labelSerie.frame;
    labelSerieFrame.origin.y = (poster.frame.origin.y + poster.frame.size.height/2) - labelSerieFrame.size.height/2 - labelEpisodio.frame.size.height/2;
    labelSerie.frame = labelSerieFrame;
    
    CGRect labelEpisodioFrame = labelEpisodio.frame;
    labelEpisodioFrame.origin.y = labelSerie.frame.origin.y + labelSerie.frame.size.height;
    labelEpisodio.frame = labelEpisodioFrame;
    
    altoCelda = poster.frame.origin.y + poster.frame.size.height + margenY;
    
    [backgroundView addSubview:poster];
    [backgroundView addSubview:labelSerie];
    [backgroundView addSubview:labelEpisodio];
    
    
    CustomCellPerfilListadoCapitulos * customCellPerfilListadoCapitulos = [[CustomCellPerfilListadoCapitulos alloc] initWithMediaElementUserPending:mediaElementUserPending];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance:backgroundView AltoCelda:altoCelda] cellText:nil selectionType:YES customCell:customCellPerfilListadoCapitulos];
    return customCellPerfilListadoCapitulos;
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
    for (MediaElementUserPending * mediaElementUserPending in source) {
        [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:mediaElementUserPending]];
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    return sections;
}

- (void) fillTableViewFromSource: (NSMutableArray *) source {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(fillTableViewInBackgroundFromSource:) object:source];
    [thread start];
}

#pragma mark -
#pragma mark refresh
-(void) refresh {
    [self downloadUserPendingInfo];
    [self performSelectorOnMainThread:@selector(stopRefreshAnimation) withObject:nil waitUntilDone:NO];
}


@end
