//
//  MasterViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "TVFramework.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomCellsMaster.h"
#import "ManejadorServicioWebSeriesly.h"
#import "UserCredentials.h"
#import "MediaElement.h"
#import "Poster.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "CustomCellResultadoBusqueda.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"NavigationBarTitle", nil);
        self.clearsSelectionOnViewWillAppear = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerHideMaster:) name:@"hide" object:nil];
    [self configureTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    [self.tableView setContentOffset:CGPointMake(0, 44.f) animated:NO];
}

-(void) viewDidAppear:(BOOL)animated {
    if (self.customTableViewController.lastCellPressed) {
        [self.customTableViewController.lastCellPressed customDeselect];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    //NSLog(@"viewWillDisappear");
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    [self.tableView setContentOffset:CGPointMake(0, 44.f) animated:NO];
}

- (void) handlerHideMaster: (NSNotification *) notification {
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
    
}

#pragma mark -
#pragma mark Set up TableView

-(CustomCell *) createCellListadoCapitulosWithMediaElementUserPending: (CustomCell *) customCell ImageName: (NSString *) imageName CellText: (NSString *) cellText {
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.borderColor = [[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0] CGColor];
    int altoCelda = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        altoCelda = 54;
    } else {
        altoCelda = 94;
    }
    UIImage * imagen = [UIImage imageNamed:imageName];
    UIImageView * imageView = [[UIImageView alloc] init];
    
    imageView.image = imagen;
    CGRect imageFrame = imageView.frame;
    imageFrame.size = imagen.size;
    imageView.frame = imageFrame;
    
    UILabel * label = [[UILabel alloc] init];
    label.text = cellText;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    [label sizeToFit];
    
    CGRect frame = imageView.frame;
    frame.origin.y = altoCelda*0.16;
    frame.origin.x = altoCelda*0.16;
    //frame.size.height = imageView.frame.size.height;
    //frame.size.width = imageView.frame.size.width;
    frame.size.height = altoCelda*0.68;
    frame.size.width = altoCelda*0.68;
    imageView.frame = frame;
    
    frame = label.frame;
    frame.origin.y = imageView.frame.origin.y + imageView.frame.size.height/2 - label.frame.size.height/2;
    frame.origin.x = imageView.frame.origin.x + imageView.frame.size.width + 15;
    label.frame = frame;
    
    //altoCelda = imageView.frame.origin.y + imageView.frame.size.height + 15;
    //NSLog(@"%d",altoCelda);
    
    [backgroundView addSubview:imageView];
    [backgroundView addSubview:label];
    
    
    
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE(backgroundView, altoCelda) cellText:nil selectionType:YES customCell:customCell];
    return customCell;
}



-(void) configureTableView {
    NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    //UILabel *labelHeader;
    
    cells = [NSMutableArray array];
    /*labelHeader = [[FabricaHeaderFooterSecciones getInstance] getNewTitleLabelWithTitle:NSLocalizedString(@"TableViewSection1Text", nil) appearance:HEADERELMUNDO2(15, 8, 160, 30)];*/
    
    CustomCellPerfil *customCellPerfil = [[CustomCellPerfil alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellPerfil ImageName:@"perfil.png" CellText:NSLocalizedString(@"TableViewPerfilCellText", nil)]];
    
    CustomCellSeries *customCellSeries = [[CustomCellSeries alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellSeries ImageName:@"series.png" CellText:NSLocalizedString(@"TableViewSeriesCellText", nil)]];
    
    CustomCellPeliculas *customCellPeliculas = [[CustomCellPeliculas alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellPeliculas ImageName:@"peliculas.png" CellText:NSLocalizedString(@"TableViewPeliculasCellText", nil)]];
    
    CustomCellDocumentales *customCellDocumentales = [[CustomCellDocumentales alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellDocumentales ImageName:@"documentales.png" CellText:NSLocalizedString(@"TableViewDocumentalesCellText", nil)]];
    
    CustomCellProgramas *customCellProgramas = [[CustomCellProgramas alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellProgramas ImageName:@"tvshows.png" CellText:NSLocalizedString(@"TableViewProgramasCellText", nil)]];
    
    CustomCellAjustes *customCellAjustes = [[CustomCellAjustes alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellAjustes ImageName:@"acerca_de.png" CellText:NSLocalizedString(@"TableViewAjustesCellText", nil)]];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:10 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    cells = [NSMutableArray array];
    CustomCellUnLogin *customCellUnLogin = [[CustomCellUnLogin alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIASALIR cellText:@"Salir" selectionType:YES customCell:customCellUnLogin];
    [cells addObject:customCellUnLogin];
    
    int salirHeaderHeight;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        salirHeaderHeight = 17;
    } else {
        salirHeaderHeight = 60;
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:salirHeaderHeight labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    // Creamos el tableView y lo anadimos a la subvista
    CGRect tableViewFrame = self.view.frame;
    self.customTableViewController = [[CustomTableViewController alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0] sections:sections viewController:self.detailViewController title:nil];
    self.customTableViewController.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [customCellPerfil executeAction:self.detailViewController];
    
    
    //[self.view addSubview:self.customTableViewController];
    //[self.tableView removeFromSuperview];
    self.tableView = self.customTableViewController;
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    [self.customTableViewController selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [customCellPerfil customSelect];
    
    //}
    [self setUpSearchBar];
    
}

#pragma mark -
#pragma mark Setup Search

-(void) setUpSearchBar {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
																					target:self
																					action:@selector(searchBar:)];
	self.navigationItem.leftBarButtonItem = rightBarButton;
	
	self.searchBar = [[UISearchBar alloc] init];
	/*[self.searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"Series",@"Películas",@"DocumentalesDocumentalesDocumentales",@"Programas",nil]];
     [self.searchBar setScopeBarButtonTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:9], UITextAttributeFont, nil] forState:UIControlStateNormal];
     [self.searchBar setScopeBarButtonTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:9], UITextAttributeFont, nil] forState:UIControlStateSelected];*/
    
    //Quitar el fondo
    [[UISearchBar appearance] setTintColor:[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]];
    if ([[[self.searchBar subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
        [[[self.searchBar subviews] objectAtIndex:0] removeFromSuperview];
    }
	self.searchBar.delegate = self;
    [self.searchBar setBackgroundColor:[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]];
	[self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
	[self.searchBar sizeToFit];
	self.tableView.tableHeaderView = self.searchBar;
    
    [self iniciarTableViewBusquedas];
    self.searchDisplayController2 = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    //_searchDisplayController = searchDisplayController;
	//[self setSearchDisplayController:searchDisplayController];
	self.searchDisplayController2.searchResultsDelegate = self.tableViewSearch;//TableViewDelegate
    self.searchDisplayController2.searchResultsDataSource = self.tableViewSearch;//TableViewDataSource
    self.searchDisplayController2.delegate = self;
    [self.searchDisplayController2 setValue:[NSNumber numberWithInt:UITableViewStyleGrouped] forKey:@"_searchResultsTableViewStyle"];

}

-(void) iniciarTableViewBusquedas {
    // Cargamos la tabla
    NSMutableArray *sections = [NSMutableArray array];
    NSMutableArray *cells;
    
    cells = [NSMutableArray array];
    
    self.tableViewSearch = [[CustomTableViewController alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
}

#pragma mark -
#pragma mark UISearchBar Delegate Methods

//Este metodo se descarga una imagen de internet y la asigna a su imageView correspondiente
-(void) configureImageView: (NSMutableDictionary *) arguments {
    UIImageView * imageView = [arguments objectForKey:@"imageView"];
    NSString * url = [arguments objectForKey:@"url"];
    UIImage * imagen;
    NSURL * imageURL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:imageURL];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    //[request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        NSData * imageData = [request responseData];
        imagen = [UIImage imageWithData:imageData];
        imageView.image = imagen;
    }
}

- (float) groupedCellMarginWithTableWidth:(float)tableViewWidth {
    float marginWidth;
    if(tableViewWidth > 20)
    {
        if(tableViewWidth < 400)
        {
            marginWidth = 10;
        }
        else
        {
            marginWidth = MAX(31, MIN(45, tableViewWidth*0.06));
        }
    }
    else
    {
        marginWidth = tableViewWidth - 10;
    }
    return marginWidth;
}

-(CustomCell *) createCellListadoSeriesWithMediaElementUser: (MediaElement *) mediaElement {
    float backgroundViewWidthMargin = [self groupedCellMarginWithTableWidth:self.view.frame.size.width];
    float backgroundViewWidth = self.view.frame.size.width - 2*backgroundViewWidthMargin;
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       backgroundViewWidth,
                                                                       0)];
    int altoCelda = 50;
    int margenX = 2;
    int margenY = 5;
    int separacionDelPoster = 10;
    UIImageView * poster = [[UIImageView alloc] initWithFrame:CGRectMake(margenX, margenY, 27, 40)];
    //poster.layer.cornerRadius = 6.0f;
    //poster.clipsToBounds = YES;
    NSString * urlImagen = mediaElement.poster.large;
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
    
    labelSerie.text = [NSString stringWithFormat:@"%@",mediaElement.name];
    labelSerie.backgroundColor = [UIColor clearColor];
    labelSerie.font = [UIFont systemFontOfSize:14];
    labelSerie.numberOfLines = 2;
    //
    [labelSerie sizeToFit];
    labelSerie.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    CGRect labelSerieFrame = labelSerie.frame;
    labelSerieFrame.origin.y = (poster.frame.origin.y + poster.frame.size.height/2) - labelSerieFrame.size.height/2;
    labelSerie.frame = labelSerieFrame;
    
    
    
    altoCelda = poster.frame.origin.y + poster.frame.size.height + margenY;
    
    [backgroundView addSubview:poster];
    [backgroundView addSubview:labelSerie];
    
    
    CustomCellResultadoBusqueda * customCellResultadoBusqueda = [[CustomCellResultadoBusqueda alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIARESULTADOSBUSQUEDA(backgroundView, altoCelda) cellText:nil selectionType:YES customCell:customCellResultadoBusqueda];
    //[[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAELMUNDOPEQUENO cellText:mediaElement.name selectionType:YES customCell:customCellResultadoBusqueda];
    return customCellResultadoBusqueda;
    
}

-(void) executeSearchWithText: (NSString *) text {
    UserCredentials * userCredentials = [UserCredentials getInstance];
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    NSMutableArray * resultados = [manejadorServicioWebSeriesly getSearchResultsWithRequest:nil ProgressView:nil AuthToken:userCredentials.authToken Query:text];
    [self performSelectorOnMainThread:@selector(createSectionsBusqueda:) withObject:resultados waitUntilDone:YES];
}

-(void) createSectionsBusqueda: (NSMutableArray *) resultados {
    NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells = [NSMutableArray array];
    for (MediaElement * mediaElement in resultados) {
        CustomCell * customCell = [self createCellListadoSeriesWithMediaElementUser:mediaElement];
        [cells addObject:customCell];
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    self.tableViewSearch.section.sections = sections;
    [self.searchDisplayController2.searchResultsTableView reloadData];
}


// Nos sirve para saber si se ha pulsado el boton de buscar
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self performSelectorInBackground:@selector(executeSearchWithText:) withObject:searchBar.text];
        
        if ([searchBar isFirstResponder]) {
            [searchBar resignFirstResponder];
            //[self.searchDisplayController2 setActive:NO];
        }
        return FALSE;
    } else if([text isEqualToString:@""]) {
        self.tableViewSearch.section.sections = [NSMutableArray array];
        [self.searchDisplayController2.searchResultsTableView reloadData];
    }
    return TRUE;
}

// Va haciendo busquedas cada vez que se escribe un caracter nuevo
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //self.valorBuscado = searchBar.text;
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"globalSearch" object:searchBar.text];
}

// Cancela la busqueda
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar isFirstResponder]) {
        [searchBar resignFirstResponder];
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tableViewSearch.section.sections removeAllObjects];
}

// Empezamos a escribir en la busqueda
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    [searchBar becomeFirstResponder];
    for(UIView *view in [searchBar subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIBarButtonItem * item = (UIBarButtonItem *)view;
            [item setTitle:@"Cancelar"];
        }
    }
    
}

// Terminamos de escribir en la busqueda
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchDisplayController2 setActive:YES];
    self.searchDisplayController2.searchResultsTableView.backgroundView = nil;
    self.searchDisplayController2.searchResultsTableView.backgroundColor = [UIColor whiteColor];
    return YES;
}


- (void) handlerResponse: (NSNotification *) notification {
    // Implementacion generica
    SectionElement *seccion = (SectionElement *)[notification object];
    //for (SectionElement * sectionElement in self.resultadoBusquedas) {
    for (SectionElement * sectionElement in self.customTableViewController.section.sections) {
        if ([sectionElement.labelHeader.text isEqualToString:seccion.labelHeader.text]) {
            [self.tableViewSearch.section.sections removeObject:sectionElement];
            break;
        }
    }
    
    if ([seccion.cells count] > 0) {
        [self.tableViewSearch.section.sections addObject:seccion];
    }
    [self.searchDisplayController2.searchResultsTableView reloadData];
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods
/*
 - (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
 [self filterContentForSearchText:searchString scope:
 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
 
 // Return YES to cause the search result table view to be reloaded.
 return YES;
 }
 
 - (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
 [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
 
 // Return YES to cause the search result table view to be reloaded.
 return YES;
 }*/

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
	/*
     Bob: Because the searchResultsTableView will be released and allocated automatically, so each time we start to begin search, we set its delegate here.
     */
    self.searchDisplayController2.searchResultsDelegate = self.tableViewSearch;//TableViewDelegate
    self.searchDisplayController2.searchResultsDataSource = self.tableViewSearch;//TableViewDataSource
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
	/*
	 Hide the search bar
	 */
	[self.tableView setContentOffset:CGPointMake(0, 44.f) animated:YES];
}



#pragma mark -

-(void)searchBar:(id)sender{
	[self.searchDisplayController2 setActive:YES animated:YES];
    [self.searchBar becomeFirstResponder];
}



@end
