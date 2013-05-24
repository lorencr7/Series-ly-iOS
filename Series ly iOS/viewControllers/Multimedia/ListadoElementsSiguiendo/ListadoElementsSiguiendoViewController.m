//
//  ListadoElementsSiguiendoViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "CustomCellSeriesListadoSeries.h"
#import "DetalleElementViewController.h"
#import "ListadoElementsSiguiendoViewController.h"
#import "ManejadorServicioWebSeriesly.h"
#import "MediaElementUser.h"
#import "Poster.h"
#import "TVFramework.h"
#import <QuartzCore/QuartzCore.h>

@interface ListadoElementsSiguiendoViewController ()

@end

@implementation ListadoElementsSiguiendoViewController

- (id)initWithFrame: (CGRect) frame DetalleElementViewController: (DetalleElementViewController *) detalleElementViewController {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.detalleElementViewController = detalleElementViewController;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
}

-(NSMutableArray *) getSectionsFromSourceData: (NSMutableArray *) sourceData {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    
    for (MediaElementUser * mediaElementUser in sourceData) {
        [cells addObject:[self createCellListadoSeriesWithMediaElementUser:mediaElementUser]];
    }
    
    
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    return sections;
}

-(void) reloadTableViewWithSections: (NSMutableArray *) sections {
    [super reloadTableViewWithSections:sections];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        SectionElement * sectionElement = [self.customTableView.section.sections objectAtIndex:0];
        if (sectionElement.cells.count > 0) {
            CustomCellSeriesListadoSeries * firstCell = [sectionElement.cells objectAtIndex:0];
            [firstCell customSelect];
            [self.customTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.detalleElementViewController reloadInfoFromMediaElementUser:firstCell.mediaElementUser];
        }
    }
    
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
    
    
    CustomCellSeriesListadoSeries * customCellSeriesListadoSeries = [[CustomCellSeriesListadoSeries alloc] initWithMediaElementUser:mediaElementUser];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance:backgroundView AltoCelda:altoCelda] cellText:nil selectionType:YES customCell:customCellSeriesListadoSeries];
    return customCellSeriesListadoSeries;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
