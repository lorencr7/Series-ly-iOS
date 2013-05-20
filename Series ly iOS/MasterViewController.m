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

#define SELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
#define TEXTSELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
#define UNSELECTEDFONTAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
#define SELECTEDFONTAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
#define TEXTALIGNMENTMASTERTABLEVIEWMASTERTABLEVIEWIPHONE 0
#define ACCESORYTYPEMASTERTABLEVIEWMASTERTABLEVIEWIPHONE UITableViewCellAccessoryNone
#define LINEBREAKMODEMASTERTABLEVIEWMASTERTABLEVIEWIPHONE 0
#define NUMBEROFLINESMASTERTABLEVIEWMASTERTABLEVIEWIPHONE 0
#define ACCESORYVIEWMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
//#define CUSTOMHEIGHTCELLMASTERTABLEVIEWMASTERTABLEVIEWIPHONE 80

#define APARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE unselectedTextFont:UNSELECTEDFONTAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE selectedTextFont:SELECTEDFONTAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE textAlignment:TEXTALIGNMENTMASTERTABLEVIEWMASTERTABLEVIEWIPHONE accesoryType:ACCESORYTYPEMASTERTABLEVIEWMASTERTABLEVIEWIPHONE lineBreakMode:LINEBREAKMODEMASTERTABLEVIEWMASTERTABLEVIEWIPHONE numberOfLines:NUMBEROFLINESMASTERTABLEVIEWMASTERTABLEVIEWIPHONE accesoryView:ACCESORYVIEWMASTERTABLEVIEWMASTERTABLEVIEWIPHONE backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]


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

#define UNSELECTEDCOLORAPARIENCIASALIR [UIColor redColor]
#define SELECTEDCOLORAPARIENCIASALIR [UIColor redColor]
#define TEXTUNSELECTEDCOLORAPARIENCIASALIR [UIColor whiteColor]
#define TEXTSELECTEDCOLORAPARIENCIASALIR [UIColor whiteColor]
#define UNSELECTEDFONTAPARIENCIASALIR [UIFont boldSystemFontOfSize:18.0]
#define SELECTEDFONTAPARIENCIASALIR [UIFont boldSystemFontOfSize:18.0]
#define BORDERCOLORSALIR [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]
#define BORDERWIDTHSALIR 0.8
#define CORNERRADIUSSALIR 0
#define TEXTALIGNMENTSALIR NSTextAlignmentCenter
#define ACCESORYTYPESALIR UITableViewCellAccessoryNone
#define LINEBREAKMODESALIR NSLineBreakByWordWrapping
#define NUMBEROFLINESSALIR 0
#define ACCESORYVIEWSALIR nil
#define HEIGHTCELLSALIR 47

#define APARIENCIASALIR [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIASALIR selectedColor:SELECTEDCOLORAPARIENCIASALIR unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIASALIR selectedTextColor:TEXTSELECTEDCOLORAPARIENCIASALIR unselectedTextFont:UNSELECTEDFONTAPARIENCIASALIR selectedTextFont:SELECTEDFONTAPARIENCIASALIR borderColor:BORDERCOLORSALIR borderWidth:BORDERWIDTHSALIR cornerRadius:CORNERRADIUSSALIR textAlignment:TEXTALIGNMENTSALIR accesoryType:ACCESORYTYPESALIR lineBreakMode:LINEBREAKMODESALIR numberOfLines:NUMBEROFLINESSALIR accesoryView:ACCESORYVIEWSALIR heightCell:HEIGHTCELLSALIR]

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
    [cells addObject:[self createCellListadoCapitulosWithMediaElementUserPending:customCellAjustes ImageName:@"ajustes.png" CellText:NSLocalizedString(@"TableViewAjustesCellText", nil)]];
    
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
    [customCellPerfil executeAction:self.detailViewController];
    
    
    //[self.view addSubview:self.customTableViewController];
    self.tableView = self.customTableViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
