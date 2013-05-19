//
//  LinksViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ListadoLinksViewController.h"
#import "ManejadorServicioWebSeriesly.h"
#import "PerfilViewController.h"
#import "UserCredentials.h"
#import "MediaElementUserPending.h"
#import "TVFramework.h"
#import "Links.h"
#import "Link.h"
#import "CustomCellLinksLink.h"
#import "Pending.h"
#import "FullInfo.h"
#import "Episode.h"
#import "EpisodeMedia.h"
#import "Season.h"
#import "SeasonsEpisodes.h"
#import "ASIHTTPRequest.h"
#import "MediaElement.h"


@interface ListadoLinksViewController ()

@end

@implementation ListadoLinksViewController

- (id)initWithFrame: (CGRect) frame MediaElement: (MediaElement *) mediaElement NavigationItem: (UINavigationItem *) navigationItem {

    self = [super init];
    if (self) {
        self.mediaElement = mediaElement;
        self.frame = frame;
        self.parentNavigationItem = navigationItem;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
    [self loadSegmentedControl];
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        self.parentNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar"
                                                                                       style:UIBarButtonItemStyleBordered
                                                                                      target:self
                                                                                      action:@selector(cancelarButtonPressed:)];
    }
}


-(void) iniciarTableView {
    NSMutableArray *sections;
    SectionElement *sectionElement;
    NSMutableArray *cells;
    CGRect frameTableView = CGRectMake(0,
                                       0,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height);
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
    
    
    [self.view addSubview:self.tableViewController.view];
}

-(void) getData {
    [super getData];
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    self.parentNavigationItem.titleView = self.segmentedControl;
}

-(NSMutableArray *) getSourceData {
    if ([self.mediaElement class] == [MediaElementUserPending class]) {
        self.mediaElementUserPending = (MediaElementUserPending *) self.mediaElement;

    } else {
    }
    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    
    UserCredentials * userCredentials = [UserCredentials getInstance];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:nil];
    [self.requests addObject:request];
    self.fullInfo = [manejadorServicioWeb getMediaFullInfoWithRequest:nil
                                                         ProgressView:nil
                                                            AuthToken:userCredentials.authToken
                                                            UserToken:userCredentials.userToken
                                                                  Idm:self.mediaElementUserPending.idm
                                                            MediaType:self.mediaElementUserPending.mediaType];
    [self.requests removeObject:request];
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    switch ([self.fullInfo.mediaType intValue]) {
        case 1:
            [self cargarLinksSeries];
            break;
        case 2:
            [self cargarLinksPeliculas];
            break;
        case 3:
            [self cargarLinksPeliculas];
            break;
        case 4:
            [self cargarLinksSeries];
            break;
            
        default:
            break;
    }
    return self.links.streaming;
}

-(NSMutableArray *) getSectionsFromSourceData: (NSMutableArray *) sourceData {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    for (Link * link in sourceData) {
        //NSString * host = [link.host lowercaseString];
        //if (![host isEqualToString:@"moevideos"] && ! [host isEqualToString:@"nowvideo"] && ! [host isEqualToString:@"magnovideo"] && ! [host isEqualToString:@"vidxden"]) {
            [cells addObject:[self createCellLinksLinkWithLink:link]];
        //}
        
    }
    if (cells.count == 0) {
        CustomCellLinksLink *customCellLinksLink = [[CustomCellLinksLink alloc] init];
        [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIALISTADOLINKS(nil, 44) cellText:@"No hay Links compatibles" selectionType:YES customCell:customCellLinksLink];
        [cells addObject:customCellLinksLink];
    }
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    return sections;
}

-(CustomCellLinksLink *) createCellLinksLinkWithLink: (Link *) link {
    CustomCellLinksLink *customCellLinksLink = [[CustomCellLinksLink alloc] initWithLink:link];
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       300,
                                                                       0)];
    int heightCell = 50;
    NSString * hostImageString = [NSString stringWithFormat:@"%@.png",[link.host lowercaseString]];
    UIImage * hostImage = [UIImage imageNamed:hostImageString];
    double maxAncho;
    int labelAutoResizingMask;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        labelAutoResizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
        maxAncho = 100;
    } else {
        labelAutoResizingMask = UIViewAutoresizingFlexibleWidth;
        maxAncho = 150;
    }
    double maxAnchoLabels = 100;
    double coeficiente = 1;
    int margenX = 5;
    if (hostImage) {
        UIImageView * imageViewHost = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageViewHost.image = hostImage;
        //imageViewHost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        CGRect imageViewWatchedFrame = imageViewHost.frame;
        imageViewWatchedFrame.origin.x = margenX;
        imageViewWatchedFrame.origin.y = (heightCell/2) - imageViewHost.image.size.height/2;
        if (imageViewHost.image.size.width > maxAncho) {
            coeficiente = maxAncho/imageViewHost.image.size.width;
        }
        imageViewWatchedFrame.size.width = imageViewHost.image.size.width * coeficiente;
        imageViewWatchedFrame.size.height = imageViewHost.image.size.height * coeficiente;
        imageViewHost.frame = imageViewWatchedFrame;
        
        [backgroundView addSubview:imageViewHost];
    } else {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(margenX, 10, maxAncho, 0)];
        label.text = link.host;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 2;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [label sizeToFit];
        [backgroundView addSubview:label];
    }
    
    UILabel * labelLang = [[UILabel alloc] initWithFrame:
                            CGRectMake(margenX + maxAncho + margenX,
                                       0,
                                       maxAnchoLabels - 10,
                                       0)];
    //
    labelLang.text = link.lang;
    labelLang.backgroundColor = [UIColor clearColor];
    labelLang.font = [UIFont systemFontOfSize:15];
    labelLang.textAlignment = NSTextAlignmentCenter;
    labelLang.lineBreakMode = NSLineBreakByWordWrapping;
    labelLang.numberOfLines = 2;
    //
    [labelLang sizeToFit];
    //labelLang.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    labelLang.autoresizingMask = labelAutoResizingMask;
    [backgroundView addSubview:labelLang];
    
    if (labelLang.frame.size.height > 50) {
        heightCell = labelLang.frame.size.height;
    }
    
    CGRect labelLangFrame = labelLang.frame;
    labelLangFrame.origin.y = (heightCell/2) - labelLangFrame.size.height/2;
    labelLangFrame.size.width = maxAnchoLabels - 10;
    labelLang.frame = labelLangFrame;
    [backgroundView addSubview:labelLang];
    
    UILabel * labelQuality = [[UILabel alloc] initWithFrame:
                           CGRectMake(labelLang.frame.origin.x + maxAnchoLabels + margenX,
                                      0,
                                      maxAnchoLabels - 10,
                                      0)];
    //
    labelQuality.text = link.quality;
    labelQuality.backgroundColor = [UIColor clearColor];
    labelQuality.font = [UIFont systemFontOfSize:15];
    labelQuality.lineBreakMode = NSLineBreakByWordWrapping;
    labelQuality.textAlignment = NSTextAlignmentCenter;
    labelQuality.numberOfLines = 2;
    //
    [labelQuality sizeToFit];
    //labelQuality.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    labelQuality.autoresizingMask = labelAutoResizingMask;
    [backgroundView addSubview:labelQuality];
    
    if (labelQuality.frame.size.height > 50) {
        heightCell = labelQuality.frame.size.height;
    }
    
    CGRect labelQualityFrame = labelQuality.frame;
    labelQualityFrame.origin.y = (heightCell/2) - labelQualityFrame.size.height/2;
    labelQualityFrame.size.width = maxAnchoLabels - 10;
    labelQuality.frame = labelQualityFrame;
    [backgroundView addSubview:labelQuality];
    
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIALISTADOLINKS(backgroundView, heightCell) cellText:nil selectionType:YES customCell:customCellLinksLink];
    return customCellLinksLink;
}


-(void) cargarLinksPeliculas {
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:nil];
    [self.requests addObject:request];
    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    self.links = [manejadorServicioWeb getLinksWithRequest:nil
                                              ProgressView:nil
                                                 AuthToken:userCredentials.authToken
                                                       Idm:self.fullInfo.idm
                                                 MediaType:[NSString stringWithFormat:@"%d",[self.fullInfo.mediaType intValue]]];
    [self.requests removeObject:request];

    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
}

-(void) cargarLinksSeries {
    BOOL hayTemporadaZero = NO;
    BOOL hayEpisodioZero = NO;
    int sesion = self.mediaElementUserPending.pending.season ;
    int capitulo = [self.mediaElementUserPending.pending.episode intValue];


    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    
    if (self.fullInfo.seasonsEpisodes.seasons.count == (self.fullInfo.seasons + 1)) {
        hayTemporadaZero = YES;
    }
    //NSLog(@"numberOfSeasons: %d vs %d",self.fullInfo.seasons,self.fullInfo.seasonsEpisodes.seasons.count);
    Season * season;
    if (hayTemporadaZero) {
        season = [self.fullInfo.seasonsEpisodes.seasons objectAtIndex:sesion];
    } else {
        season = [self.fullInfo.seasonsEpisodes.seasons objectAtIndex:sesion - 1];
    }
    
    
    
    Episode * firstEpisode = [season.episodes objectAtIndex:0];
    if ([firstEpisode.episode intValue] == 0) {
        hayEpisodioZero = YES;
    }
    Episode * episode;
    if (hayEpisodioZero) {
        episode = [season.episodes objectAtIndex:capitulo];
    } else {
        episode = [season.episodes objectAtIndex:capitulo - 1];
    }
    
    self.links = [manejadorServicioWeb getLinksWithRequest:nil
                                              ProgressView:nil
                                                 AuthToken:userCredentials.authToken
                                                       Idm:episode.idm
                                                 MediaType:[NSString stringWithFormat:@"%d",episode.mediaType]];
    
}

-(void) cancelarButtonPressed: (UIButton *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) loadSegmentedControl {
    self.segmentedControl =[[UISegmentedControl alloc]
                            initWithItems:[NSArray arrayWithObjects:
                                           @"Streaming",@"Oficial", nil]];
    
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
}

- (IBAction)manejadorSegmented:(UISegmentedControl *) sender {
    NSMutableArray * sections;
    switch (sender.selectedSegmentIndex) {
        case 0:
            sections = [self getSectionsFromSourceData:self.links.streaming];
            break;
        case 1:
            sections = [self getSectionsFromSourceData:self.links.officialServer];
            break;
        default:
            break;
    }
    [self reloadTableViewWithSections:sections];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
