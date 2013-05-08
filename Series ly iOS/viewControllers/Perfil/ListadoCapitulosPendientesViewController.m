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
#import "ASIHTTPRequest.h"




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
    /*self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
     self.view.layer.shadowOffset = CGSizeMake(-3,5);
     self.view.layer.shadowRadius = 3;
     self.view.layer.shadowOpacity = 0.3;
     CGRect shadowFrame = self.view.layer.bounds;
     CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
     self.view.layer.shadowPath = shadowPath;*/
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self iniciarTableViewEpisodiosPendientes];
    [self iniciarActivityIndicator];
    [self.activityIndicatorView startAnimating];
    
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadUserPendingInfo) object:nil];
    [thread start];
    //[self downloadUserPendingInfo];
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
        
    [self iniciarRefreshControl];
    [self.tableViewEpisodios addSubview:self.refreshControl];
    
    //self.tableViewEpisodios.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:self.tableViewEpisodios];
}





-(void) refresh {
    [self downloadUserPendingInfo];
    [self performSelectorOnMainThread:@selector(stopRefreshAnimation) withObject:nil waitUntilDone:NO];
}



-(void) downloadUserPendingInfo {
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    User * usuario = [User getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    //Descargamos los capitulos de las series pendientes del usuario
    NSMutableDictionary * userPendingInfo = [manejadorServicioWebSeriesly getUserPendingInfoWithRequest:nil ProgressView:nil AuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
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
    
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
}

-(void) fillTableViewFromSourceType:(TipoSourceData)sourceType {
    User * usuario = [User getInstance];
    BOOL hayNuevosDatos = NO;
    switch (sourceType) {
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
    if (self.lastSourceData) {
        if (![self.lastSourceData isEqualToArray:self.sourceData]) {
            hayNuevosDatos = YES;
        }
    } else {
        hayNuevosDatos = YES;
    }
    
    if (self.sourceData && hayNuevosDatos) {
        self.lastSourceData = self.sourceData;
        [self fillTableViewInBackgroundFromSource:self.sourceData];
    }
}

#define SELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPAD [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPAD nil
#define TEXTSELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPAD nil
#define UNSELECTEDFONTAPARIENCIALISTADOCAPITULOSIPAD nil
#define SELECTEDFONTAPARIENCIALISTADOCAPITULOSIPAD nil
#define TEXTALIGNMENTLISTADOCAPITULOSIPAD 0
#define ACCESORYTYPELISTADOCAPITULOSIPAD UITableViewCellAccessoryNone
#define LINEBREAKMODELISTADOCAPITULOSIPAD 0
#define NUMBEROFLINESLISTADOCAPITULOSIPAD 0
#define ACCESORYVIEWLISTADOCAPITULOSIPAD nil
//#define CUSTOMHEIGHTCELLLISTADOCAPITULOSIPAD 80

#define APARIENCIALISTADOCAPITULOSIPAD(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPAD unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPAD selectedTextColor:TEXTSELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPAD unselectedTextFont:UNSELECTEDFONTAPARIENCIALISTADOCAPITULOSIPAD selectedTextFont:SELECTEDFONTAPARIENCIALISTADOCAPITULOSIPAD textAlignment:TEXTALIGNMENTLISTADOCAPITULOSIPAD accesoryType:ACCESORYTYPELISTADOCAPITULOSIPAD lineBreakMode:LINEBREAKMODELISTADOCAPITULOSIPAD numberOfLines:NUMBEROFLINESLISTADOCAPITULOSIPAD accesoryView:ACCESORYVIEWLISTADOCAPITULOSIPAD backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]

#define SELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPHONE [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPHONE nil
#define TEXTSELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPHONE nil
#define UNSELECTEDFONTAPARIENCIALISTADOCAPITULOSIPHONE nil
#define SELECTEDFONTAPARIENCIALISTADOCAPITULOSIPHONE nil
#define TEXTALIGNMENTLISTADOCAPITULOSIPHONE 0
#define ACCESORYTYPELISTADOCAPITULOSIPHONE UITableViewCellAccessoryDisclosureIndicator
#define LINEBREAKMODELISTADOCAPITULOSIPHONE 0
#define NUMBEROFLINESLISTADOCAPITULOSIPHONE 0
#define ACCESORYVIEWLISTADOCAPITULOSIPHONE nil
//#define CUSTOMHEIGHTCELLLISTADOCAPITULOSIPHONE 80

#define APARIENCIALISTADOCAPITULOSIPHONE(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPHONE unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPHONE selectedTextColor:TEXTSELECTEDCOLORAPARIENCIALISTADOCAPITULOSIPHONE unselectedTextFont:UNSELECTEDFONTAPARIENCIALISTADOCAPITULOSIPHONE selectedTextFont:SELECTEDFONTAPARIENCIALISTADOCAPITULOSIPHONE textAlignment:TEXTALIGNMENTLISTADOCAPITULOSIPHONE accesoryType:ACCESORYTYPELISTADOCAPITULOSIPHONE lineBreakMode:LINEBREAKMODELISTADOCAPITULOSIPHONE numberOfLines:NUMBEROFLINESLISTADOCAPITULOSIPHONE accesoryView:ACCESORYVIEWLISTADOCAPITULOSIPHONE backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]

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
