//
//  ListadoCapitulosPendientesViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ListadoCapitulosPendientesViewController.h"
#import "ManejadorServicioWebSeriesly.h"
#import "User.h"
#import "UserCredentials.h"
#import "TVFramework.h"
#import "CustomCellPerfilSeleccionSeriesPendientes.h"
#import "MediaElementUserPending.h"
#import <QuartzCore/QuartzCore.h>
#import "Pending.h"
#import "CustomCellPerfilListadoCapitulos.h"
#import "Poster.h"


@interface ListadoCapitulosPendientesViewController ()

@end

@implementation ListadoCapitulosPendientesViewController

- (id)initWithFrame: (CGRect) frame SourceData: (TipoSourceData) tipoSourceData{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.tipoSourceData = tipoSourceData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = self.frame;
    self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.view.layer.shadowOffset = CGSizeMake(-3,5);
    self.view.layer.shadowRadius = 3;
    self.view.layer.shadowOpacity = 0.3;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    [self iniciarTableViewEpisodiosPendientes];
    NSThread * thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserPendingInfo) object:nil];
    [thread2 start];
	// Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated {
    if (self.tableViewEpisodios.lastCellPressed) {
        [self.tableViewEpisodios.lastCellPressed customDeselect];
    }
}

-(void) iniciarTableViewEpisodiosPendientes {
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
    self.tableViewEpisodios = [[CustomTableViewController alloc] initWithFrame:frameTableViewEpisodios style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewEpisodios.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableViewEpisodios.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:self.tableViewEpisodios];
}

-(void) downloadUserPendingInfo {
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    User * usuario = [User getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    //Descargamos los capitulos de las series pendientes del usuario
    NSMutableDictionary * userPendingInfo = [manejadorServicioWebSeriesly getUserPendingInfoWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
    if (!userPendingInfo) {
        NSLog(@"error descargando la info de pendientes del usuario");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ups" message:@"No se pudo descargar los capítulos pendientes" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        usuario.seriesPendientes = [userPendingInfo objectForKey:@"series"];
        usuario.peliculasPendientes = [userPendingInfo objectForKey:@"movies"];
        usuario.documentalesPendientes = [userPendingInfo objectForKey:@"documentaries"];
        usuario.tvShowsPendientes = [userPendingInfo objectForKey:@"tvshows"];
        //Rellenamos el tableView con los capitulos de series pendientes
    }
    [self fillTableViewFromSourceType:self.tipoSourceData];
}

-(void) fillTableViewFromSourceType:(TipoSourceData)sourceType {
    User * usuario = [User getInstance];
    NSMutableArray * sourceData;
    switch (sourceType) {
        case SourceSeriesPendientes:
            sourceData = usuario.seriesPendientes;
            break;
        case SourcePeliculasPendientes:
            sourceData = usuario.peliculasPendientes;
            break;
        case SourceDocumentalesPendientes:
            sourceData = usuario.documentalesPendientes;
            break;
        case SourceTVShowsPendientes:
            sourceData = usuario.tvShowsPendientes;
            break;
            
        default:
            break;
    }
    if (sourceData) {
        [self fillTableViewFromSource:sourceData];
    }
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
}

//idem que metodo anterior pero lanzando un thread. Se debe llamar a este metodo
- (void) fillTableViewFromSource: (NSMutableArray *) source {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(fillTableViewInBackgroundFromSource:) object:source];
    [thread start];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
