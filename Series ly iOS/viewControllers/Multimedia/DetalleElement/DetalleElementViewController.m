//
//  DetalleElementViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DetalleElementViewController.h"
#import "FullInfo.h"
#import "ManejadorServicioWebSeriesly.h"
#import "UserCredentials.h"
#import "MediaElementUser.h"
#import "Poster.h"
#import <QuartzCore/QuartzCore.h>
#import "Director.h"
#import "TVFramework.h"
#import "SeasonsEpisodes.h"
#import "Season.h"
#import "Episode.h"
#import "VerLinksViewController.h"
#import "CustomCellMultimediaListadoCapitulos.h"
#import "Pending.h"
#import "DetalleInformacionViewController.h"
#import "DetalleEnlacesViewController.h"


@interface DetalleElementViewController ()

@end

@implementation DetalleElementViewController

- (id)initWithFrame: (CGRect) frame MediaElementUser: (MediaElementUser *) mediaElementUser {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.mediaElementUser = mediaElementUser;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
    
    //NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadFullInfoFromMediaElementUser:) object:self.mediaElementUser];
    //[thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadInfoFromMediaElementUser: (MediaElementUser *) mediaElementUser {
    self.mediaElementUser = mediaElementUser;
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self performSelectorOnMainThread:@selector(activateActivityIndicator) withObject:nil waitUntilDone:YES];
    [self performSelectorInBackground:@selector(downloadFullInfoFromMediaElementUser:) withObject:mediaElementUser];
}

-(void) getData {
    [self downloadFullInfoFromMediaElementUser:self.mediaElementUser];
}

-(void) downloadFullInfoFromMediaElementUser: (MediaElementUser *) mediaElementUser {
    [self.threads addObject:[NSThread currentThread]];
    
    if (mediaElementUser) {
        ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
        
        UserCredentials * userCredentials = [UserCredentials getInstance];
        
        self.fullInfo = [manejadorServicioWeb getMediaFullInfoWithRequest:nil
                                                             ProgressView:nil
                                                                AuthToken:userCredentials.authToken
                                                                UserToken:userCredentials.userToken
                                                                      Idm:mediaElementUser.idm
                                                                MediaType:mediaElementUser.mediaType];
        if (self.fullInfo) {
            [self performSelectorOnMainThread:@selector(createContent) withObject:nil waitUntilDone:YES];
        }
        
        
    }
    
    [self stopActivityIndicator];
}

-(void) createContent {
    CGRect elementsFrame;
    if (self.fullInfo.seasonsEpisodes) {
        [self loadSegmentedControl];
        int topViewSize = self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
        elementsFrame = CGRectMake(0,
                                  topViewSize,
                                  self.view.frame.size.width,
                                  self.view.frame.size.height - topViewSize);
        self.detalleInformacionViewController = [[DetalleInformacionViewController alloc] initWithFrame:elementsFrame FullInfo:self.fullInfo];
        
        self.detalleEnlacesViewController = [[DetalleEnlacesViewController alloc] initWithFrame:elementsFrame FullInfo:self.fullInfo MediaElementUser:self.mediaElementUser];
        [self addChildViewController:self.detalleEnlacesViewController];
    } else {
        [self loadButtonVerEnlaces];
        int topViewSize = self.buttonVerEnlaces.frame.origin.y + self.buttonVerEnlaces.frame.size.height;
        elementsFrame = CGRectMake(0,
                                   topViewSize,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height - topViewSize);
        self.detalleInformacionViewController = [[DetalleInformacionViewController alloc] initWithFrame:elementsFrame FullInfo:self.fullInfo];

    }
    [self addChildViewController:self.detalleInformacionViewController];
    [self.view addSubview:self.detalleInformacionViewController.view];
    /*if (self.fullInfo) {
        self.altoContenidoScrollView = 0;
        if (self.fullInfo.seasonsEpisodes) {
            [self loadSegmentedControl];
            [self createFichaFromFullInfo:self.fullInfo];
            [self createCapitulosFromFullInfo:self.fullInfo];
        } else {
            [self loadButtonVerEnlaces];
            [self createFichaFromFullInfo:self.fullInfo];
        }
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.altoContenidoScrollView + 20);
    }*/
}

/*-(void) createCapitulosFromFullInfo: (FullInfo *) fullInfo {
    [self iniciarTableView];
    NSMutableArray * sections = [self createSectionsFromFullInfo:fullInfo];
    [self performSelectorOnMainThread:@selector(reloadTableViewWithSections:) withObject:sections waitUntilDone:YES];
}

-(NSMutableArray *) createSectionsFromFullInfo: (FullInfo *) fullInfo {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    UILabel * labelHeader;
    NSMutableArray * seasons = [NSMutableArray arrayWithArray:fullInfo.seasonsEpisodes.seasons];
    
    if (fullInfo.seasonsEpisodes.seasons.count == (fullInfo.seasons + 1)) {
        Season * season0 = seasons[0];
        [seasons removeObject:season0];
        //[seasons addObject:season0];
    }
    
    int sesion = 1;
    int capitulo = 1;
    for (Season * season in seasons) {
        Episode * firstEpisode = [season.episodes objectAtIndex:0];
        if ([firstEpisode.episode intValue] == 0) {
            capitulo = 0;
        }
        cells = [NSMutableArray array];
        for (Episode * episode in season.episodes) {
            if (![episode.title isEqualToString:@""]) {
                [cells addObject:[self createCellFromEpisode:episode Sesion:sesion Capitulo:capitulo]];
            }
            capitulo ++;
        }
        NSString * labelHeaderText = [NSString stringWithFormat:@"  Temporada %@",season.season];
        labelHeader = [[FabricaHeaderFooterSecciones getInstance] getNewTitleLabelWithTitle:labelHeaderText appearance:HEADERLISTADOCAPITULOSTITULO(0, 0, self.tableViewController.view.frame.size.width, 22)];
        sectionElement = [[SectionElement alloc] initWithHeightHeader:22 labelHeader:labelHeader heightFooter:40 labelFooter:nil cells:cells];
        [sections addObject:sectionElement];
        sesion++;
        capitulo = 1;
    }
    
    
    
    //sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    //[sections addObject:sectionElement];
    return sections;
}

-(CustomCellMultimediaListadoCapitulos *) createCellFromEpisode: (Episode *) episode Sesion: (int) sesion Capitulo: (int) capitulo {
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       300,
                                                                       0)];
    
    Pending * pending = [[Pending alloc] init];
    pending.season = sesion;
    pending.episode = [NSString stringWithFormat:@"%d",capitulo];
    CustomCellMultimediaListadoCapitulos * customCellMultimediaListadoCapitulos = [[CustomCellMultimediaListadoCapitulos alloc] initWithMediaElementUser:self.mediaElementUser Pending:pending];
    int heightCell = 55;
    int spaceForIcons = 83;
    
    UILabel * labelSerie = [[UILabel alloc] initWithFrame:
                            CGRectMake(10,
                                       0,
                                       backgroundView.frame.size.width - spaceForIcons - 30,
                                       0)];
    //
    NSString * cellText = [NSString stringWithFormat:@"%dx%d\t%@",sesion,capitulo,episode.title];
    labelSerie.text = cellText;
    labelSerie.backgroundColor = [UIColor clearColor];
    labelSerie.font = [UIFont systemFontOfSize:17];
    labelSerie.lineBreakMode = NSLineBreakByWordWrapping;
    labelSerie.numberOfLines = 2;
    //
    [labelSerie sizeToFit];
    labelSerie.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [backgroundView addSubview:labelSerie];
    
    if (labelSerie.frame.size.height > 50) {
        heightCell = labelSerie.frame.size.height;
    }
    
    CGRect labelSerieFrame = labelSerie.frame;
    labelSerieFrame.origin.y = (heightCell/2) - labelSerieFrame.size.height/2;
    labelSerie.frame = labelSerieFrame;
    
    UIImageView * imageViewWatched = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                   0,
                                                                                   0,
                                                                                   0)];
    imageViewWatched.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    if (episode.watched) {
        imageViewWatched.image = [UIImage imageNamed:@"media_watched.png"];
    } else {
        imageViewWatched.image = [UIImage imageNamed:@"media_dontwatched.png"];
    }
    
    CGRect imageViewWatchedFrame = imageViewWatched.frame;
    imageViewWatchedFrame.origin.x = backgroundView.frame.size.width - spaceForIcons;
    imageViewWatchedFrame.origin.y = (heightCell/2) - imageViewWatched.image.size.height/2;
    imageViewWatchedFrame.size.width = imageViewWatched.image.size.width;
    imageViewWatchedFrame.size.height = imageViewWatched.image.size.height;
    imageViewWatched.frame = imageViewWatchedFrame;
    
    [backgroundView addSubview:imageViewWatched];
    
    UIImageView * imageViewhaveLinks = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                   0,
                                                                                   0,
                                                                                   0)];
    imageViewhaveLinks.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    if (episode.haveLinks) {
        imageViewhaveLinks.image = [UIImage imageNamed:@"media_havelinks.png"];
    } else {
        imageViewhaveLinks.image = [UIImage imageNamed:@"media_donthavelinks.png"];
    }
    
    CGRect imageViewhaveLinksFrame = imageViewhaveLinks.frame;
    imageViewhaveLinksFrame.origin.x = imageViewWatched.frame.origin.x + imageViewWatched.frame.size.width + 2;
    imageViewhaveLinksFrame.origin.y = (heightCell/2) - imageViewhaveLinks.image.size.height/2;
    imageViewhaveLinksFrame.size.width = imageViewhaveLinks.image.size.width;
    imageViewhaveLinksFrame.size.height = imageViewhaveLinks.image.size.height;
    imageViewhaveLinks.frame = imageViewhaveLinksFrame;
    
    [backgroundView addSubview:imageViewhaveLinks];
    
    //poster.layer.cornerRadius = 6.0f;
    //poster.clipsToBounds = YES;
    
    
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIALISTADOLINKS(backgroundView, heightCell) cellText:nil selectionType:episode.haveLinks customCell:customCellMultimediaListadoCapitulos];
    return customCellMultimediaListadoCapitulos;
} */
/*-(void) createFichaFromFullInfo: (FullInfo *) fullInfo {
    [self iniciarScrollView];
    [self createPosterSectionWithFullInfo:fullInfo];
    [self createPlotLabelWithText:fullInfo.plot];
}

-(void) createPosterSectionWithFullInfo: (FullInfo *) fullInfo {
    int margenX = 5;
    int margenY = 20;
    UIImageView * poster = [[UIImageView alloc] initWithFrame:CGRectMake(margenX, margenY, 131.25, 195)];
    poster.layer.cornerRadius = 6.0f;
    poster.clipsToBounds = YES;
    NSString * urlImagen = fullInfo.poster.large;
    if (urlImagen) {
        NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
        [arguments setObject:poster forKey:@"imageView"];
        [arguments setObject:urlImagen forKey:@"url"];
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureImageView:) object:arguments];
        [thread start];
    }
    [self.scrollView addSubview:poster];
    
    int margenEtiquetas = 15;
    int margenContenidos = 5;
    int origenXEtiquetas = poster.frame.origin.x + poster.frame.size.width + margenEtiquetas;
    int widthEtiquetas = 65;
    int origenXContenidos = origenXEtiquetas + margenContenidos + widthEtiquetas;
    int widthContenidos = self.scrollView.frame.size.width - origenXContenidos - 5;
    
    int origenY = poster.frame.origin.y;
    int margenEntreEtiquetas = 13;
    if (fullInfo.year && ![fullInfo.year isEqualToString:@""]) {
        UILabel * labelEtiquetaAno = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaAno.backgroundColor = [UIColor clearColor];
        labelEtiquetaAno.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaAno.text = @"Año";
        labelEtiquetaAno.numberOfLines = 0;
        labelEtiquetaAno.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaAno sizeToFit];
        
        UILabel * labelContenidoAno = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoAno.backgroundColor = [UIColor clearColor];
        labelContenidoAno.font = [UIFont systemFontOfSize:13];
        labelContenidoAno.text = fullInfo.year;
        labelContenidoAno.numberOfLines = 0;
        labelContenidoAno.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelContenidoAno sizeToFit];
        
        [self.scrollView addSubview:labelEtiquetaAno];
        [self.scrollView addSubview:labelContenidoAno];
        
        origenY += labelContenidoAno.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.country.count > 0) {
        UILabel * labelEtiquetaPais = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaPais.backgroundColor = [UIColor clearColor];
        labelEtiquetaPais.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaPais.text = @"País";
        labelEtiquetaPais.numberOfLines = 0;
        labelEtiquetaPais.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaPais sizeToFit];
        
        UILabel * labelContenidoPais = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoPais.backgroundColor = [UIColor clearColor];
        labelContenidoPais.font = [UIFont systemFontOfSize:13];
        NSString * text;
        int i = 0;
        for (NSString * country in fullInfo.country) {
            if (i == 0) {
                text = [NSString stringWithFormat:@"%@",country];
                i++;
            } else {
                text = [NSString stringWithFormat:@"%@, %@",text,country];
            }
        }
        labelContenidoPais.text = text;
        labelContenidoPais.numberOfLines = 0;
        labelContenidoPais.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelContenidoPais sizeToFit];
        [self.scrollView addSubview:labelEtiquetaPais];
        [self.scrollView addSubview:labelContenidoPais];
        origenY += labelContenidoPais.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.runtime) {
        UILabel * labelEtiquetaDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaDuracion.backgroundColor = [UIColor clearColor];
        labelEtiquetaDuracion.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaDuracion.text = @"Duración";
        labelEtiquetaDuracion.numberOfLines = 0;
        labelEtiquetaDuracion.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaDuracion sizeToFit];
        
        UILabel * labelContenidoDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoDuracion.backgroundColor = [UIColor clearColor];
        labelContenidoDuracion.font = [UIFont systemFontOfSize:13];
        NSString * text = [NSString stringWithFormat:@"%@ minutos",fullInfo.runtime];
        labelContenidoDuracion.text = text;
        labelContenidoDuracion.numberOfLines = 0;
        labelContenidoDuracion.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelContenidoDuracion sizeToFit];
        [self.scrollView addSubview:labelEtiquetaDuracion];
        [self.scrollView addSubview:labelContenidoDuracion];
        origenY += labelContenidoDuracion.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.genres.count > 0) {
        UILabel * labelEtiquetaGenre = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaGenre.backgroundColor = [UIColor clearColor];
        labelEtiquetaGenre.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaGenre.text = @"Género";
        labelEtiquetaGenre.numberOfLines = 0;
        labelEtiquetaGenre.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaGenre sizeToFit];
        
        UILabel * labelContenidoGenre = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoGenre.backgroundColor = [UIColor clearColor];
        labelContenidoGenre.font = [UIFont systemFontOfSize:13];
        NSString * text;
        int i = 0;
        for (NSString * country in fullInfo.genres) {
            if (i == 0) {
                text = [NSString stringWithFormat:@"%@",country];
                i++;
            } else {
                text = [NSString stringWithFormat:@"%@, %@",text,country];
            }
        }
        labelContenidoGenre.text = text;
        labelContenidoGenre.numberOfLines = 0;
        labelContenidoGenre.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelContenidoGenre sizeToFit];
        [self.scrollView addSubview:labelEtiquetaGenre];
        [self.scrollView addSubview:labelContenidoGenre];
        origenY += labelContenidoGenre.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.director.count > 0) {
        UILabel * labelEtiquetaDirector = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaDirector.backgroundColor = [UIColor clearColor];
        labelEtiquetaDirector.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaDirector.text = @"Director";
        labelEtiquetaDirector.numberOfLines = 0;
        labelEtiquetaDirector.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaDirector sizeToFit];
        
        UILabel * labelEtiquetaDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelEtiquetaDuracion.backgroundColor = [UIColor clearColor];
        labelEtiquetaDuracion.font = [UIFont systemFontOfSize:13];
        Director * director = fullInfo.director[0];
        NSString * text = director.name;
        labelEtiquetaDuracion.text = text;
        labelEtiquetaDuracion.numberOfLines = 0;
        labelEtiquetaDuracion.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaDuracion sizeToFit];
        [self.scrollView addSubview:labelEtiquetaDirector];
        [self.scrollView addSubview:labelEtiquetaDuracion];
        origenY += labelEtiquetaDuracion.frame.size.height + margenEntreEtiquetas;
    }
    
    int altoSeccion = poster.frame.size.height;
    
    self.altoContenidoScrollView += altoSeccion + margenY;
    
}

-(void) createPlotLabelWithText: (NSString *) text {
    
    int margenX = 10;
    int margenYSinopsis = 20;
    int originYSinopsis = self.altoContenidoScrollView + margenYSinopsis;
    UILabel * sinopsisLabel = [[UILabel alloc] initWithFrame:CGRectMake(margenX, originYSinopsis, self.view.frame.size.width - 2*margenX, 0)];
    sinopsisLabel.backgroundColor = [UIColor clearColor];
    sinopsisLabel.font = [UIFont boldSystemFontOfSize:20];
    sinopsisLabel.text = @"Sinopsis";
    sinopsisLabel.numberOfLines = 0;
    sinopsisLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [sinopsisLabel sizeToFit];
    [self.scrollView addSubview:sinopsisLabel];
    
    int margenYPlot = 10;
    int originYPlotLabel = sinopsisLabel.frame.origin.y + sinopsisLabel.frame.size.height + margenYPlot;
    UILabel * plotLabel = [[UILabel alloc] initWithFrame:CGRectMake(margenX, originYPlotLabel, self.view.frame.size.width - 2*margenX, 0)];
    plotLabel.backgroundColor = [UIColor clearColor];
    plotLabel.font = [UIFont systemFontOfSize:14];
    plotLabel.text = text;
    plotLabel.numberOfLines = 0;
    plotLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [plotLabel sizeToFit];
    [self.scrollView addSubview:plotLabel];
    
    int altoSeccion = plotLabel.frame.size.height + sinopsisLabel.frame.size.height + margenYSinopsis + margenYPlot;
    self.altoContenidoScrollView += altoSeccion;
    
}*/

/*-(void) iniciarScrollView {
    int topViewSize = 0;
    if (self.segmentedControl) {
        topViewSize += self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
    }
    if (self.buttonVerEnlaces) {
        topViewSize += self.buttonVerEnlaces.frame.origin.y + self.buttonVerEnlaces.frame.size.height;
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                     topViewSize,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height - topViewSize)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = self.scrollView.frame.size;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scrollView];
}*/

/*-(void) iniciarTableView {
    NSMutableArray *sections;
    SectionElement *sectionElement;
    NSMutableArray *cells;
    CGRect frameTableView = self.scrollView.frame;
    sections = [NSMutableArray array];
    cells = [NSMutableArray array];
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    self.customTableView = [[CustomTableViewController alloc] initWithFrame:frameTableView style:UITableViewStylePlain backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.customTableView.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.tableViewController = [[UITableViewController alloc] init];
    self.tableViewController.tableView = (UITableView *)self.customTableView;
    self.tableViewController.view.alpha = 1;
    [self addChildViewController:self.tableViewController];
    
    self.tableViewController.view.frame = self.scrollView.frame;
    self.customTableView.frame = self.scrollView.frame;
}*/

-(void) loadButtonVerEnlaces {
    self.buttonVerEnlaces = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    int alto = 40;
    int margen = 5;
    self.buttonVerEnlaces.frame = CGRectMake(margen, margen+5, self.view.frame.size.width - 2*margen, alto);
    [self.buttonVerEnlaces addTarget:self
                              action:@selector(manejadorButtonVerEnlaces:)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.buttonVerEnlaces setTitle:@"Ver enlaces" forState:UIControlStateNormal];
    self.buttonVerEnlaces.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.buttonVerEnlaces];
}

-(void) loadSegmentedControl {
    int alto = 35;
    int margen = 5;
    self.segmentedControl =[[UISegmentedControl alloc]
                            initWithItems:[NSArray arrayWithObjects:
                                           @"Ficha",@"Capítulos", nil]];
    self.segmentedControl.frame = CGRectMake(margen, margen+5, self.view.frame.size.width - 2*margen, alto);
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // Ponemos el manejador
    [self.segmentedControl   addTarget:self
                                action:@selector(manejadorSegmented:)
                      forControlEvents:UIControlEventValueChanged];
    
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.tintColor = [UIColor colorWithRed:(135/255.0) green:(174/255.0) blue:(232/255.0) alpha:1];
    
    
    [self.segmentedControl setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:
                                                     [UIColor blackColor],
                                                     UITextAttributeTextColor,
                                                     [UIColor colorWithRed:(140.0/255.0) green:(175.0/255.0) blue:(224.0/255.0) alpha:1.0],
                                                     UITextAttributeTextShadowColor,
                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                     UITextAttributeTextShadowOffset,
                                                     [UIFont boldSystemFontOfSize:12.5f],
                                                     UITextAttributeFont,
                                                     nil]  forState:UIControlStateNormal];
    
    [self.segmentedControl setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:
                                                     [UIColor whiteColor],
                                                     UITextAttributeTextColor,
                                                     [UIColor whiteColor],
                                                     UITextAttributeTextShadowColor,
                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                     UITextAttributeTextShadowOffset,
                                                     [UIFont systemFontOfSize:12.5f],
                                                     UITextAttributeFont,
                                                     nil]  forState:UIControlStateSelected];
    
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.segmentedControl];
    
}

- (IBAction)manejadorButtonVerEnlaces:(UIButton *) sender {
    Pending * pending = [[Pending alloc] init];
    CustomCellMultimediaListadoCapitulos * customCellMultimediaListadoCapitulos = [[CustomCellMultimediaListadoCapitulos alloc] initWithMediaElementUser:self.mediaElementUser Pending:pending];
    [customCellMultimediaListadoCapitulos executeAction:self];
    /*VerLinksViewController * linksViewController = [[VerLinksViewController alloc] initWithMediaElement:self.mediaElementUser];
     UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:linksViewController];
     navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
     navigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
     [self presentViewController:navigationController animated:YES completion:nil];*/
    
}

- (IBAction)manejadorSegmented:(UISegmentedControl *) sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.view addSubview: self.detalleInformacionViewController.view];
            [self.detalleEnlacesViewController.view removeFromSuperview];
            //[self.tableViewController.view removeFromSuperview];
            //[self.view addSubview:self.scrollView];
            break;
        case 1:
            [self.view addSubview: self.detalleEnlacesViewController.view];
            [self.detalleInformacionViewController.view removeFromSuperview];
            //[self.scrollView removeFromSuperview];
            //[self.view addSubview:self.tableViewController.view];
            break;
        default:
            break;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    int topViewSize = 0;
    if (self.segmentedControl) {
        topViewSize += self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
    }
    if (self.buttonVerEnlaces) {
        topViewSize += self.buttonVerEnlaces.frame.origin.y + self.buttonVerEnlaces.frame.size.height;
    }
    CGRect frame = CGRectMake(0,
                              topViewSize,
                              self.view.frame.size.width,
                              self.view.frame.size.height - topViewSize);
    self.detalleEnlacesViewController.view.frame = frame;
    self.detalleInformacionViewController.view.frame = frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            self.detalleInformacionViewController.scrollView.contentSize = CGSizeMake(frame.size.width, self.detalleInformacionViewController.scrollView.contentSize.height);
            
        } else {
            
        }
    }
}

@end
