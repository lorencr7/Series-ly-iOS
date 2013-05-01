//
//  ListadoOpcionesPerfilViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ListadoOpcionesPerfilViewController.h"
#import "TVFramework.h"
#import "CustomCellsSeleccionPerfil.h"
#import <QuartzCore/QuartzCore.h>


@interface ListadoOpcionesPerfilViewController ()

@end

@implementation ListadoOpcionesPerfilViewController

- (id)initWithFrame: (CGRect) frame ListadoCapitulosPendientes: (ListadoCapitulosPendientesViewController *) listadoCapitulosPendientes {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.listadoCapitulosPendientes = listadoCapitulosPendientes;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.frame = self.frame;
    [self loadEpisodes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadEpisodes {
    CGRect frameTableViewSeleccion = CGRectMake(0,
                                                0,
                                                self.view.frame.size.width,
                                                self.view.frame.size.height);

    
    NSMutableArray *sections;
    NSMutableArray *cells;
    
    cells = [NSMutableArray array];
    
    sections = [self crearSectionsSeleccion];
    
    self.tableViewSeleccion = [[CustomTableViewController alloc] initWithFrame:frameTableViewSeleccion style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:(UIViewController *)self.listadoCapitulosPendientes title:nil];
    self.tableViewSeleccion.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableViewSeleccion.layer.borderWidth = 0;
    self.tableViewSeleccion.bounces = YES;
    self.tableViewSeleccion.layer.borderColor = [[UIColor grayColor] CGColor];
    self.tableViewSeleccion.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    /*if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        SectionElement * secionElement = [self.tableViewSeleccion.section.sections objectAtIndex:0];
        CustomCellPerfilSeleccionSeriesPendientes * customCellPerfilSeleccionSeriesPendiente = [secionElement.cells objectAtIndex:0];
        [customCellPerfilSeleccionSeriesPendiente customSelect];
        
        [self.tableViewSeleccion selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }*/
    [self.view addSubview:self.tableViewSeleccion];
}

#define UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor whiteColor]
#define SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]
#define TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(100/255.0) alpha:1]
#define TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor whiteColor]
#define UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE [UIFont systemFontOfSize:18.0]
#define SELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE [UIFont systemFontOfSize:18.0]
#define BORDERCOLORPERFILSELECCIONIPHONE [UIColor whiteColor]
#define BORDERWIDTHPERFILSELECCIONIPHONE 0.8
#define CORNERRADIUSPERFILSELECCIONIPHONE 0
#define TEXTALIGNMENTPERFILSELECCIONIPHONE NSTextAlignmentLeft
#define ACCESORYTYPEPERFILSELECCIONIPHONE UITableViewCellAccessoryDisclosureIndicator
#define LINEBREAKMODEPERFILSELECCIONIPHONE NSLineBreakByWordWrapping
#define NUMBEROFLINESPERFILSELECCIONIPHONE 0
#define ACCESORYVIEWPERFILSELECCIONIPHONE nil
#define HEIGHTCELLPERFILSELECCIONIPHONE 68

#define APARIENCIAPERFILSELECCIONIPHONE [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE selectedColor:SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE unselectedTextFont:UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE selectedTextFont:SELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE borderColor:BORDERCOLORPERFILSELECCIONIPHONE borderWidth:BORDERWIDTHPERFILSELECCIONIPHONE cornerRadius:CORNERRADIUSPERFILSELECCIONIPHONE textAlignment:TEXTALIGNMENTPERFILSELECCIONIPHONE accesoryType:ACCESORYTYPEPERFILSELECCIONIPHONE lineBreakMode:LINEBREAKMODEPERFILSELECCIONIPHONE numberOfLines:NUMBEROFLINESPERFILSELECCIONIPHONE accesoryView:ACCESORYVIEWPERFILSELECCIONIPHONE heightCell:HEIGHTCELLPERFILSELECCIONIPHONE]

#define UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor whiteColor]
#define SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]
#define TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(100/255.0) alpha:1]
#define TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor whiteColor]
#define UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD [UIFont systemFontOfSize:20.0]
#define SELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD [UIFont systemFontOfSize:20.0]
#define BORDERCOLORPERFILSELECCIONIPAD [UIColor whiteColor]
#define BORDERWIDTHPERFILSELECCIONIPAD 0.8
#define CORNERRADIUSPERFILSELECCIONIPAD 0
#define TEXTALIGNMENTPERFILSELECCIONIPAD NSTextAlignmentLeft
#define ACCESORYTYPEPERFILSELECCIONIPAD UITableViewCellAccessoryDisclosureIndicator
#define LINEBREAKMODEPERFILSELECCIONIPAD NSLineBreakByWordWrapping
#define NUMBEROFLINESPERFILSELECCIONIPAD 0
#define ACCESORYVIEWPERFILSELECCIONIPAD nil
#define HEIGHTCELLPERFILSELECCIONIPAD 90

#define APARIENCIAPERFILSELECCIONIPAD [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD selectedColor:SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD unselectedTextFont:UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD selectedTextFont:SELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD borderColor:BORDERCOLORPERFILSELECCIONIPAD borderWidth:BORDERWIDTHPERFILSELECCIONIPAD cornerRadius:CORNERRADIUSPERFILSELECCIONIPAD textAlignment:TEXTALIGNMENTPERFILSELECCIONIPAD accesoryType:ACCESORYTYPEPERFILSELECCIONIPAD lineBreakMode:LINEBREAKMODEPERFILSELECCIONIPAD numberOfLines:NUMBEROFLINESPERFILSELECCIONIPAD accesoryView:ACCESORYVIEWPERFILSELECCIONIPAD heightCell:HEIGHTCELLPERFILSELECCIONIPAD]

- (NSMutableArray *) crearSectionsSeleccion {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    CustomCellPerfilSeleccionPeliculasPendientes *customCellPerfilSeleccionPeliculasPendientes = [[CustomCellPerfilSeleccionPeliculasPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance] cellText:@"Películas pendientes" selectionType:YES customCell:customCellPerfilSeleccionPeliculasPendientes];
    [cells addObject:customCellPerfilSeleccionPeliculasPendientes];
    
    CustomCellPerfilSeleccionDocumentalesPendientes *customCellPerfilSeleccionDocumentalesPendientes = [[CustomCellPerfilSeleccionDocumentalesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance] cellText:@"Documentales pendientes" selectionType:YES customCell:customCellPerfilSeleccionDocumentalesPendientes];
    [cells addObject:customCellPerfilSeleccionDocumentalesPendientes];
    
    CustomCellPerfilSeleccionTVShowsPendientes *customCellPerfilSeleccionTVShowsPendientes = [[CustomCellPerfilSeleccionTVShowsPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance] cellText:@"TVShows pendientes" selectionType:YES customCell:customCellPerfilSeleccionTVShowsPendientes];
    [cells addObject:customCellPerfilSeleccionTVShowsPendientes];
    
    CustomCellPerfilSeleccionSeriesPendientes *customCellPerfilSeleccionSeriesPendiente = [[CustomCellPerfilSeleccionSeriesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance] cellText:@"Series pendientes" selectionType:YES customCell:customCellPerfilSeleccionSeriesPendiente];
    [cells addObject:customCellPerfilSeleccionSeriesPendiente];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    return sections;
}

-(CustomCellAppearance *) getAppearance {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return APARIENCIAPERFILSELECCIONIPHONE;
    } else {
        return APARIENCIAPERFILSELECCIONIPAD;
    }
}


@end
