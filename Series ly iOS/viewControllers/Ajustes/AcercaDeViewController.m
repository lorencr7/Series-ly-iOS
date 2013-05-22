//
//  AcercaDeViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 20/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "AcercaDeViewController.h"
#import "TVFramework.h"
#import <QuartzCore/QuartzCore.h>


@interface AcercaDeViewController ()

@end

@implementation AcercaDeViewController

- (id)initWithFrame: (CGRect) frame {
    self = [super init];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *) getSectionsFromSourceData: (NSMutableArray *) sourceData {
    NSMutableArray *sections = [NSMutableArray array];
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    //UILabel *labelHeader;
    
    cells = [NSMutableArray array];
    /*labelHeader = [[FabricaHeaderFooterSecciones getInstance] getNewTitleLabelWithTitle:NSLocalizedString(@"TableViewSection1Text", nil) appearance:HEADERELMUNDO2(15, 8, 160, 30)];*/
    CustomCell *customCell;
    
    customCell = [[CustomCell alloc] init];
    [cells addObject:[self createCellAcercaDe:customCell CellText:@"Series.ly Versión 1.0 - 20 de Mayo de 2013"]];
    
    customCell = [[CustomCell alloc] init];
    [cells addObject:[self createCellAcercaDe:customCell CellText:@"Autor: Lorenzo Villarroel"]];
    
    customCell = [[CustomCell alloc] init];
    [cells addObject:[self createCellAcercaDe:customCell CellText:@"Colaborador: Abimael Barea"]];
    
    customCell = [[CustomCell alloc] init];
    [cells addObject:[self createCellAcercaDe:customCell CellText:@"Esta aplicación ha sido desarrollada con el objetivo de contar con una app que se conecte a Series.ly y que se pueda ver el contenido de esta red social. En un futuro se le irán añadiendo más funcionalidades."]];
    
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    return sections;
}


-(CustomCell *) createCellAcercaDe: (CustomCell *) customCell CellText: (NSString *) cellText {
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       300,
                                                                       0)];
    backgroundView.layer.borderWidth = 0.8;
    backgroundView.layer.borderColor = [[UIColor colorWithRed:(213/255.0) green:(216/255.0) blue:(217/255.0) alpha:1.0] CGColor];
    int heightCell = 50;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                                0,
                                                                280,
                                                                0)];
    label.text = cellText;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    [label sizeToFit];
    

    CGRect labelSerieFrame = label.frame;
    labelSerieFrame.origin.y = (heightCell/2) - labelSerieFrame.size.height/2;
    label.frame = labelSerieFrame;
    
    [backgroundView addSubview:label];
    if (label.frame.size.height > heightCell) {
        heightCell = label.frame.size.height + 5;
    }
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPERFILSELECCIONIPHONE cellText:cellText selectionType:NO customCell:customCell];
    customCell.customCellAppearance.heightCell = heightCell;
    //[[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAACERCADE(backgroundView, heightCell) cellText:nil selectionType:NO customCell:customCell];
    return customCell;
}

@end
