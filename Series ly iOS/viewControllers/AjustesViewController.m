//
//  AjustesViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "AjustesViewController.h"
#import "ScreenSizeManager.h"
#import "TVFramework.h"
#import "ConstantsCustomSplitViewController.h"
#import "CustomCellsAjustes.h"
#import <QuartzCore/QuartzCore.h>

@interface AjustesViewController ()

@end

@implementation AjustesViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"TableViewSettingsCellText", nil);
    }
    return self;
}

- (void) loadData {
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void) configureAjustesWindow {
    
    NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    UILabel *labelHeader;
    
    //section 3
    cells = [NSMutableArray array];
    
    labelHeader = [[FabricaHeaderFooterSecciones getInstance] getNewTitleLabelWithTitle:NSLocalizedString(@"TextHeaderSettingsAbout", @"The string in the header of the first section") appearance:HEADERELMUNDO2(15, 8, 160, 30)];
    labelHeader.textColor = [UIColor blackColor];
    
    CustomCellAjustesAutores *customCellAjustesAutores = [[CustomCellAjustesAutores alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCION cellText:NSLocalizedString(@"TextCellAutores", @"The string in the first cell") selectionType:YES customCell:customCellAjustesAutores];
    //customCellAjustesAutores.cell.accessoryType = UITableViewCellAccessoryNone;
    //customCellAjustesAutores.cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cells addObject:customCellAjustesAutores];
    
    CustomCell *customCellAjustesVersion = [[CustomCell alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCION cellText:NSLocalizedString(@"TextCellVersion", @"The string in the first cell") selectionType:NO customCell:customCellAjustesVersion];
    customCellAjustesVersion.cell.accessoryType = UITableViewCellAccessoryNone;
    customCellAjustesVersion.cell.textLabel.textAlignment = NSTextAlignmentRight;
    [cells addObject:customCellAjustesVersion];
    
    //sectionElement = [[SectionElement alloc] initWithHeightHeader:40 labelHeader:labelHeader heightFooter:0 labelFooter:nil cells:cells];
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    //section 2
    cells = [NSMutableArray array];
    
    labelHeader = [[FabricaHeaderFooterSecciones getInstance] getNewTitleLabelWithTitle:NSLocalizedString(@"TextHeaderSettingsRate", @"The string in the header of the first section") appearance:HEADERELMUNDO2(15, 8, 160, 30)];
    labelHeader.textColor = [UIColor blackColor];
    
    CustomCell *customCellAjustesRate = [[CustomCell alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCION cellText:NSLocalizedString(@"TextCellRate", @"The string in the first cell") selectionType:YES customCell:customCellAjustesRate];
    customCellAjustesRate.cell.accessoryType = UITableViewCellAccessoryNone;
    customCellAjustesRate.cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cells addObject:customCellAjustesRate];
    
    CustomCell *customCellAjustesFeedback = [[CustomCell alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCION cellText:NSLocalizedString(@"TextCellFeedback", @"The string in the first cell") selectionType:YES customCell:customCellAjustesFeedback];
    customCellAjustesFeedback.cell.accessoryType = UITableViewCellAccessoryNone;
    customCellAjustesFeedback.cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cells addObject:customCellAjustesFeedback];
    
    //sectionElement = [[SectionElement alloc] initWithHeightHeader:40 labelHeader:labelHeader heightFooter:0 labelFooter:nil cells:cells];
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        frame.origin.x = 0;
        [self loadListadoAjustesWithFrame:frame Sections:sections];
    } else {
        int anchoDiferente = 60;//diferencia de tamaño de los tableView
        
        CGRect frameListado;
        CGRect frameDetalle;
        
        //Asignamos el frame al UIView que contiene el tableView de la izquierda
        frameListado = self.view.frame;
        frameListado.origin.x = 0;
        frameListado.origin.y = 0;
        frameListado.size.width = self.view.frame.size.width/2 - anchoDiferente;
        frameListado.size.height = self.view.frame.size.height;
        [self loadListadoAjustesWithFrame:frameListado Sections:sections];
        
        frameDetalle = self.view.frame;
        frameDetalle.origin.x = frameListado.origin.x + frameListado.size.width;
        frameDetalle.origin.y = 0;
        frameDetalle.size.width = self.view.frame.size.width/2 + anchoDiferente;
        frameDetalle.size.height = self.view.frame.size.height;
        [self loadDetalleAjustesWithFrame:frameDetalle];
    }

    
}

-(void) loadListadoAjustesWithFrame: (CGRect) frame Sections: (NSMutableArray *) sections {}
-(void) loadDetalleAjustesWithFrame: (CGRect) frame {}

-(void) iniciarAutores {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation AjustesViewControllerIpad

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) rotateToLandscape: (NSNotification *) notification {
    self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
    //NSLog(@"A landscape");
}

- (void) rotateToPortrait: (NSNotification *) notification {
    self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
    //NSLog(@"A portrait");
}

- (void) loadData {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        self.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscapeConNavigationBar);
    } else {
        self.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortraitConNavigationBar);
    }
    
    [super loadData]; // Llamamos al loadData del padre
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToLandscape:) name:@"RotateToLandscape" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateToPortrait:) name:@"RotateToPortrait" object:nil];
    
    [self configureAjustesWindow];
}

-(void) loadListadoAjustesWithFrame: (CGRect) frame Sections: (NSMutableArray *) sections {
    self.viewTableAjustes = [[UIView alloc] initWithFrame:frame];
    self.viewTableAjustes.backgroundColor = [UIColor whiteColor];
    self.viewTableAjustes.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.viewTableAjustes.alpha = 0.0;
    
    self.tableViewAjustes = [[CustomTableViewController alloc] initWithFrame:self.viewTableAjustes.frame style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewAjustes.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableViewAjustes.bounces = YES;
    
    [self.viewTableAjustes addSubview:self.tableViewAjustes];
    [self.view addSubview:self.viewTableAjustes];
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.viewTableAjustes.alpha = 1.0;
    } completion:^(BOOL finished){
        
    }];
}

-(void) loadDetalleAjustesWithFrame: (CGRect) frame {
    
    self.viewDetalleAjustes = [[UIView alloc] initWithFrame:frame];
    self.viewDetalleAjustes.backgroundColor = [UIColor whiteColor];
    self.viewDetalleAjustes.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.viewDetalleAjustes.layer.shadowOffset = CGSizeMake(-3,5);
    self.viewDetalleAjustes.layer.shadowRadius = 3;
    self.viewDetalleAjustes.layer.shadowOpacity = 0.3;
    self.viewDetalleAjustes.backgroundColor = [UIColor whiteColor];
    self.viewDetalleAjustes.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.viewDetalleAjustes.alpha = 0.0;
    
    [self.view addSubview:self.viewDetalleAjustes];
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.viewDetalleAjustes.alpha = 1.0;
    } completion:^(BOOL finished){
        
    }];
    /*NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    //section 1
    cells = [NSMutableArray array];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    self.tableViewListadoCapitulos = [[CustomTableViewController alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewListadoCapitulos.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableViewListadoCapitulos.bounces = YES;
    
    self.viewDetalleSeries = [[UIView alloc] init];
    self.viewDetalleSeries.backgroundColor = [UIColor whiteColor];
    self.viewDetalleSeries.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.viewDetalleSeries.layer.shadowOffset = CGSizeMake(-3,5);
    self.viewDetalleSeries.layer.shadowRadius = 3;
    self.viewDetalleSeries.layer.shadowOpacity = 0.3;
    self.viewDetalleSeries.backgroundColor = [UIColor whiteColor];
    self.viewDetalleSeries.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.viewListadoSeries.alpha = 0.0;
    
    [self.viewDetalleSeries addSubview:self.tableViewListadoCapitulos];
    [self.view addSubview:self.viewDetalleSeries];*/
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarAutores {
    [super iniciarAutores];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
    label.text = @"Autoreeees";
    [label sizeToFit];
    [self.viewDetalleAjustes addSubview:label];
}

@end

@implementation AjustesViewControllerIphone

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) loadData {
    [super loadData];
    
    CGSize screenSize = [ScreenSizeManager currentSize];
    CGFloat screenHeight = screenSize.height;
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    viewFrame.size.height = screenHeight - self.navigationController.navigationBar.frame.size.height - self.navigationController.tabBarController.tabBar.frame.size.height;
    self.view.frame = viewFrame;
    
    [self configureAjustesWindow];

    
}


-(void) loadListadoAjustesWithFrame: (CGRect) frame Sections: (NSMutableArray *) sections {   
    self.tableViewAjustes = [[CustomTableViewController alloc] initWithFrame:frame style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    [self.view addSubview:self.tableViewAjustes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarAutores {
    [super iniciarAutores];
}

@end
