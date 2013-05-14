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
    self.view.backgroundColor = [UIColor clearColor];
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
    
    self.tableViewSeleccion = [[CustomTableViewController alloc] initWithFrame:frameTableViewSeleccion style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
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



- (NSMutableArray *) crearSectionsSeleccion {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    CustomCellPerfilSeleccionSeriesPendientes *customCellPerfilSeleccionSeriesPendiente = [[CustomCellPerfilSeleccionSeriesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance] cellText:@"Series pendientes" selectionType:YES customCell:customCellPerfilSeleccionSeriesPendiente];
    
    
    CustomCellPerfilSeleccionPeliculasPendientes *customCellPerfilSeleccionPeliculasPendientes = [[CustomCellPerfilSeleccionPeliculasPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance] cellText:@"Películas pendientes" selectionType:YES customCell:customCellPerfilSeleccionPeliculasPendientes];
    
    
    CustomCellPerfilSeleccionDocumentalesPendientes *customCellPerfilSeleccionDocumentalesPendientes = [[CustomCellPerfilSeleccionDocumentalesPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance] cellText:@"Documentales pendientes" selectionType:YES customCell:customCellPerfilSeleccionDocumentalesPendientes];
    
    
    CustomCellPerfilSeleccionTVShowsPendientes *customCellPerfilSeleccionTVShowsPendientes = [[CustomCellPerfilSeleccionTVShowsPendientes alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:[self getAppearance] cellText:@"TVShows pendientes" selectionType:YES customCell:customCellPerfilSeleccionTVShowsPendientes];
    
    
    [cells addObject:customCellPerfilSeleccionSeriesPendiente];
    [cells addObject:customCellPerfilSeleccionPeliculasPendientes];
    [cells addObject:customCellPerfilSeleccionDocumentalesPendientes];
    [cells addObject:customCellPerfilSeleccionTVShowsPendientes];
    
    
    
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
