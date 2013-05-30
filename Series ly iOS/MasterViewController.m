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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    [self.tableView setContentOffset:CGPointMake(0, 44.f) animated:NO];
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
	
	UISearchBar *mySearchBar = [[UISearchBar alloc] init];
	/*[mySearchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"Series",@"Películas",@"DocumentalesDocumentalesDocumentales",@"Programas",nil]];
     [mySearchBar setScopeBarButtonTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:9], UITextAttributeFont, nil] forState:UIControlStateNormal];
     [mySearchBar setScopeBarButtonTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:9], UITextAttributeFont, nil] forState:UIControlStateSelected];*/
    
    //Quitar el fondo
    if ([[[mySearchBar subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
        [[[mySearchBar subviews] objectAtIndex:0] removeFromSuperview];
    }
	mySearchBar.delegate = self;
    [mySearchBar setBackgroundColor:[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]];
	[mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
	[mySearchBar sizeToFit];
	self.tableView.tableHeaderView = mySearchBar;
    
    self.searchDisplayController2 = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    //_searchDisplayController = searchDisplayController;
	//[self setSearchDisplayController:searchDisplayController];
	[self.searchDisplayController2 setDelegate:self];
	[self.searchDisplayController2 setSearchResultsDataSource:self];
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
	[self.searchDisplayController2.searchResultsTableView setDelegate:self];
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
}



@end
