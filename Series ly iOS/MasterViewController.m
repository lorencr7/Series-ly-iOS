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
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }
    return self;
}
							
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureTableView];
}

-(void) viewDidAppear:(BOOL)animated {
    if (self.customTableViewController.lastCellPressed) {
        [self.customTableViewController.lastCellPressed customDeselect];
    }
}

-(CustomCell *) createCellListadoCapitulosWithMediaElementUserPending: (CustomCell *) customCell ImageName: (NSString *) imageName CellText: (NSString *) cellText {
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.borderColor = [[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0] CGColor];
    int altoCelda = 0;
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
    frame.origin.y = 15;
    frame.origin.x = 15;
    //frame.size.height = imageView.frame.size.height;
    //frame.size.width = imageView.frame.size.width;
    frame.size.height = 64;
    frame.size.width = 64;
    imageView.frame = frame;
    
    frame = label.frame;
    frame.origin.y = imageView.frame.origin.y + imageView.frame.size.height/2 - label.frame.size.height/2;
    frame.origin.x = imageView.frame.origin.x + imageView.frame.size.width + 15;
    label.frame = frame;

    altoCelda = imageView.frame.origin.y + imageView.frame.size.height + 15;
    
    [backgroundView addSubview:imageView];
    [backgroundView addSubview:label];
    
    
    
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAMASTERTABLEVIEW(backgroundView, altoCelda) cellText:nil selectionType:YES customCell:customCell];
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
    
    CustomCellProgramas *customCellProgramas = [[CustomCellProgramas alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellProgramas ImageName:@"tvshows.png" CellText:NSLocalizedString(@"TableViewProgramasCellText", nil)]];


    CustomCellDocumentales *customCellDocumentales = [[CustomCellDocumentales alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellDocumentales ImageName:@"documentales.png" CellText:NSLocalizedString(@"TableViewDocumentalesCellText", nil)]];
    
    CustomCellAjustes *customCellAjustes = [[CustomCellAjustes alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellAjustes ImageName:@"ajustes.png" CellText:NSLocalizedString(@"TableViewAjustesCellText", nil)]];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:10 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    cells = [NSMutableArray array];
    CustomCellUnLogin *customCellUnLogin = [[CustomCellUnLogin alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIASALIR cellText:@"Salir" selectionType:YES customCell:customCellUnLogin];
    [cells addObject:customCellUnLogin];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:60 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    // Creamos el tableView y lo anadimos a la subvista
    CGRect tableViewFrame = self.view.frame;
    self.customTableViewController = [[CustomTableViewController alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0] sections:sections viewController:self.detailViewController title:nil];
    [customCellPerfil executeAction:self.detailViewController];
    /*[customCellPerfil customSelect];
    [self.customTableViewController selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];*/
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.customTableViewController = [[CustomTableViewController alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0] sections:sections viewController:self.detailViewController title:nil];
        [customCellPerfil executeAction:self.detailViewController];
        [customCellPerfil customSelect];
        [self.customTableViewController selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else {
       self.customTableViewController = [[CustomTableViewController alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0] sections:sections viewController:self.detailViewController title:nil];
        [customCellPerfil executeAction:self.detailViewController];
        [customCellPerfil customSelect];
        [self.customTableViewController selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }*/
    
    
    
    //[self.view addSubview:self.customTableViewController];
    self.tableView = self.customTableViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
