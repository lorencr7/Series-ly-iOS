//
//  DetalleEnlacesViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 22/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DetalleEnlacesViewController.h"
#import "TVFramework.h"
#import "FullInfo.h"
#import "Season.h"
#import "SeasonsEpisodes.h"
#import "Episode.h"
#import "Pending.h"
#import "CustomCellMultimediaListadoCapitulos.h"


@interface DetalleEnlacesViewController ()

@end

@implementation DetalleEnlacesViewController

- (id)initWithFrame: (CGRect) frame FullInfo: (FullInfo *) fullInfo MediaElementUser: (MediaElementUser *) mediaElementUser {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.fullInfo = fullInfo;
        self.mediaElementUser = mediaElementUser;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void) getData {
    [self createCapitulosFromFullInfo:self.fullInfo];
}*/

-(void) createCapitulosFromFullInfo: (FullInfo *) fullInfo {
    //[self iniciarTableView];
    //NSMutableArray * sections = [self createSectionsFromFullInfo:fullInfo];
    //[self performSelectorOnMainThread:@selector(reloadTableViewWithSections:) withObject:sections waitUntilDone:YES];
}


-(NSMutableArray *) getSectionsFromSourceData: (NSMutableArray *) sourceData {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells;
    UILabel * labelHeader;
    NSMutableArray * seasons = [NSMutableArray arrayWithArray:self.fullInfo.seasonsEpisodes.seasons];
    
    if (self.fullInfo.seasonsEpisodes.seasons.count == (self.fullInfo.seasons + 1)) {
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
        /*if (sesion == seasons.count) {
         sesion = 0;
         } else {
         sesion++;
         }*/
        sesion++;
        capitulo = 1;
    }
    return sections;
}

-(CustomCellMultimediaListadoCapitulos *) createCellFromEpisode: (Episode *) episode Sesion: (int) sesion Capitulo: (int) capitulo {
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       self.customTableView.frame.size.width,
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
                                       backgroundView.frame.size.width - spaceForIcons - 20,
                                       42)];
    //
    NSString * cellText = [NSString stringWithFormat:@"%dx%d\t%@",sesion,capitulo,episode.title_es];
    labelSerie.text = cellText;
    labelSerie.backgroundColor = [UIColor clearColor];
    labelSerie.font = [UIFont systemFontOfSize:17];
    labelSerie.lineBreakMode = NSLineBreakByTruncatingTail;
    labelSerie.numberOfLines = 2;
    labelSerie.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //
    //[labelSerie sizeToFit];
    
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

@end
