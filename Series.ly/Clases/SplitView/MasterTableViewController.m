//
//  MasterTableViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 08/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "MasterTableViewController.h"
#import "TVFramework.h"
#import "CustomCellMasterPerfil.h"
#import "DetailViewController.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController

- (id)initWithFrame:(CGRect)frame DetailViewController: (DetailViewController *) detailViewController {
    self = [super initWithFrame:frame];
    if (self) {
        self.detailViewController = detailViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarTableView {
    [super iniciarTableView];
    self.customTableView.viewController = self.detailViewController;
}

-(NSMutableArray *) getSourceData {
    
    NSMutableArray * array = [NSMutableArray array];
    return array;
}

-(NSMutableArray *) getSectionsFromSourceData: (NSMutableArray *) sourceData {
    NSMutableArray * sections = [NSMutableArray array];
    SectionElement * sectionElement;
    NSMutableArray * cells = [NSMutableArray array];
    
    CustomCellMasterPerfil *customCellPerfil = [[CustomCellMasterPerfil alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElement:customCellPerfil ImageName:@"perfilMaster.png" CellText:@"perfil"]];
    [customCellPerfil executeAction:self.detailViewController];
    
    CustomCellMasterPerfil *customCellPerfil2 = [[CustomCellMasterPerfil alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElement:customCellPerfil2 ImageName:@"perfilMaster.png" CellText:@"perfil"]];

    
    CustomCellMasterPerfil *customCellPerfil3 = [[CustomCellMasterPerfil alloc] init];
    [cells addObject:[self createCellListadoCapitulosWithMediaElement:customCellPerfil3 ImageName:@"perfilMaster.png" CellText:@"perfil"]];


    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    //sourceData = nil;
    //[self performSelectorInBackground:@selector(configureImagenes:) withObject:self.imagenes];
    return sections;
}

-(CustomCell *) createCellListadoCapitulosWithMediaElement: (CustomCell *) customCell ImageName: (NSString *) imageName CellText: (NSString *) cellText {
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor clearColor];
    //backgroundView.layer.borderWidth = 1;
    //backgroundView.layer.borderColor = [[UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0] CGColor];
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

@end
