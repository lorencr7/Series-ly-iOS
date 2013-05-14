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

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadEpisodes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadEpisodes {
    NSMutableArray *sections = [self crearSectionsSeleccion];
    [self reloadTableViewWithSections:sections];
    [self stopActivityIndicator];
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
