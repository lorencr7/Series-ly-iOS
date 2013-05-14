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


@interface ListadoLinksViewController ()

@end

@implementation ListadoLinksViewController

- (id)initWithFrame: (CGRect) frame MediaElementUserPending: (MediaElementUserPending *) mediaElementUserPending NavigationItem: (UINavigationItem *) navigationItem {
    self = [super init];
    if (self) {
        self.mediaElementUserPending = mediaElementUserPending;
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
        
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadLinks) object:nil];
    [thread start];
	// Do any additional setup after loading the view.
}

/*-(void) viewDidAppear:(BOOL)animated {
    if (self.tableViewLinks.lastCellPressed) {
        [self.tableViewLinks.lastCellPressed customDeselect];
    }
}*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) cancelarButtonPressed: (UIButton *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) refresh {
    [self downloadLinks];
    [self performSelectorOnMainThread:@selector(stopRefreshAnimation) withObject:nil waitUntilDone:NO];
}

-(void) downloadLinks {
    
    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    
    UserCredentials * userCredentials = [UserCredentials getInstance];
    self.fullInfo = [manejadorServicioWeb getMediaFullInfoWithRequest:nil
                                                         ProgressView:nil
                                                            AuthToken:userCredentials.authToken
                                                            UserToken:userCredentials.userToken
                                                                  Idm:self.mediaElementUserPending.idm
                                                            MediaType:self.mediaElementUserPending.mediaType];
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
    self.parentNavigationItem.titleView = self.segmentedControl;
}

-(void) cargarLinksPeliculas {
    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    self.links = [manejadorServicioWeb getLinksWithRequest:nil
                                              ProgressView:nil
                                                 AuthToken:userCredentials.authToken
                                                       Idm:self.fullInfo.idm
                                                 MediaType:[NSString stringWithFormat:@"%d",[self.fullInfo.mediaType intValue]]];
    [self loadTableViewWithLinks:self.links];
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
    [self loadTableViewWithLinks:self.links];
    
}

-(void) loadTableViewWithLinks: (Links *) links {
    NSMutableArray *sections = [self crearSectionsLinksWithLinks:links.streaming];
    [self reloadTableViewWithSections:sections];
    [self stopActivityIndicator];    
}

#define SELECTEDCOLORAPARIENCIALISTADOLINKS [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIALISTADOLINKS nil
#define TEXTSELECTEDCOLORAPARIENCIALISTADOLINKS nil
#define UNSELECTEDFONTAPARIENCIALISTADOLINKS nil
#define SELECTEDFONTAPARIENCIALISTADOLINKS nil
#define TEXTALIGNMENTLISTADOLINKS 0
#define ACCESORYTYPELISTADOLINKS UITableViewCellAccessoryNone
#define LINEBREAKMODELISTADOLINKS 0
#define NUMBEROFLINESLISTADOLINKS 0
#define ACCESORYVIEWLISTADOLINKS nil
//#define CUSTOMHEIGHTCELLLISTADOLINKS 80

#define APARIENCIALISTADOLINKS(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIALISTADOLINKS unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIALISTADOLINKS selectedTextColor:TEXTSELECTEDCOLORAPARIENCIALISTADOLINKS unselectedTextFont:UNSELECTEDFONTAPARIENCIALISTADOLINKS selectedTextFont:SELECTEDFONTAPARIENCIALISTADOLINKS textAlignment:TEXTALIGNMENTLISTADOLINKS accesoryType:ACCESORYTYPELISTADOLINKS lineBreakMode:LINEBREAKMODELISTADOLINKS numberOfLines:NUMBEROFLINESLISTADOLINKS accesoryView:ACCESORYVIEWLISTADOLINKS backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]

- (NSMutableArray *) crearSectionsLinksWithLinks: (NSMutableArray *) links {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    for (Link * link in links) {
        NSString * host = [link.host lowercaseString];
        if (![host isEqualToString:@"moevideos"] && ! [host isEqualToString:@"nowvideo"] && ! [host isEqualToString:@"magnovideo"] && ! [host isEqualToString:@"vidxden"]) {
            [cells addObject:[self createCellLinksLinkWithLink:link]];
        }
        
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
    UIView * view = [[UIView alloc] init];
    int heightCell = 44;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
    label.text = link.host;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIALISTADOLINKS(view, heightCell) cellText:nil selectionType:YES customCell:customCellLinksLink];
    return customCellLinksLink;
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
            sections = [self crearSectionsLinksWithLinks:self.links.streaming];
            break;
        case 1:
            sections = [self crearSectionsLinksWithLinks:self.links.officialServer];
            break;
        default:
            break;
    }
    [self reloadTableViewWithSections:sections];
    //self.tableViewLinks.section.sections = sections;
    //[self.tableViewLinks reloadData];
}

@end
