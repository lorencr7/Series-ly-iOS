//
//  LoadableViewController.h
//  FI UPM
//
//  Created by Lorenzo Villarroel on 14/05/13.
//  Copyright (c) 2013 Laboratorio Ingeniería del Software. All rights reserved.
//

#import "LoadableViewController.h"

@class CustomTableViewController;
@interface LoadableWithTableViewController : LoadableViewController 

@property (strong, nonatomic) CustomTableViewController *customTableView;
@property (strong, nonatomic) UITableViewController *tableViewController;

@property (strong, nonatomic) NSMutableArray * sourceData;

-(void) iniciarTableView;

-(NSMutableArray *) getSourceData;

-(NSMutableArray *) getSectionsFromSourceData: (NSMutableArray *) sourceData;

-(void) reloadTableViewWithSections: (NSMutableArray *) sections;

@end
#define UNSELECTEDCOLORAPARIENCIAMENSAJEERROR [UIColor whiteColor]
#define SELECTEDCOLORAPARIENCIAMENSAJEERROR [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIAMENSAJEERROR [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(100/255.0) alpha:1]
#define TEXTSELECTEDCOLORAPARIENCIAMENSAJEERROR [UIColor whiteColor]
#define UNSELECTEDFONTAPARIENCIAMENSAJEERROR [UIFont systemFontOfSize:16.0]
#define SELECTEDFONTAPARIENCIAMENSAJEERROR [UIFont systemFontOfSize:16.0]
#define BORDERCOLORMENSAJEERROR [UIColor colorWithRed:(215.0/255.0) green:(214.0/255.0) blue:(211.0/255.0) alpha:1.0]
#define BORDERWIDTHMENSAJEERROR 0.8
#define CORNERRADIUSMENSAJEERROR 0
#define TEXTALIGNMENTMENSAJEERROR NSTextAlignmentLeft
#define ACCESORYTYPEMENSAJEERROR UITableViewCellAccessoryNone
#define LINEBREAKMODEMENSAJEERROR NSLineBreakByTruncatingTail
#define NUMBEROFLINESMENSAJEERROR 0
#define ACCESORYVIEWMENSAJEERROR nil
#define HEIGHTCELLMENSAJEERROR 50

#define APARIENCIAMENSAJEERROR [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIAMENSAJEERROR selectedColor:SELECTEDCOLORAPARIENCIAMENSAJEERROR unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAMENSAJEERROR selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAMENSAJEERROR unselectedTextFont:UNSELECTEDFONTAPARIENCIAMENSAJEERROR selectedTextFont:SELECTEDFONTAPARIENCIAMENSAJEERROR borderColor:BORDERCOLORMENSAJEERROR borderWidth:BORDERWIDTHMENSAJEERROR cornerRadius:CORNERRADIUSMENSAJEERROR textAlignment:TEXTALIGNMENTMENSAJEERROR accesoryType:ACCESORYTYPEMENSAJEERROR lineBreakMode:LINEBREAKMODEMENSAJEERROR numberOfLines:NUMBEROFLINESMENSAJEERROR accesoryView:ACCESORYVIEWMENSAJEERROR heightCell:HEIGHTCELLMENSAJEERROR]