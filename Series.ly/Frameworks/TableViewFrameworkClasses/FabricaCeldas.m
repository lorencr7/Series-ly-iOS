//
//  FabricaCeldas.m
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FabricaCeldas.h"
#import "CustomCell.h"
#import "CustomCellAppearance.h"
#import <QuartzCore/QuartzCore.h>

/*@property (assign,nonatomic) double cornerRadius;
 @property (assign,nonatomic) UITextAlignment textAlignment;
 @property (assign,nonatomic) UITableViewCellAccessoryType accesoryType;
 @property (assign,nonatomic) UILineBreakMode lineBreakMode;
 @property (assign,nonatomic) int numberOfLines;*/



static FabricaCeldas * instance;


@implementation FabricaCeldas

+(FabricaCeldas *) getInstance {
    if (instance == nil) {
        instance = [[FabricaCeldas alloc] init];
        
    }
    return instance;
}

-(void) createNewCustomCellWithAppearance:(CustomCellAppearance *) appearance cellText: (NSString *) cellText selectionType: (BOOL) selectionType customCell:(CustomCell *) customCell {
    
    //CustomCell * customCell = [[CustomCell alloc] initWithSelectionType:selectionType];
    
    //Modificamos el aspecto y las caracteristicas de la celda
    customCell.isSelectable = selectionType;
    customCell.cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celda"];
    
    customCell.cell.textLabel.text = cellText;//Texto de la celda
    customCell.cell.textLabel.textAlignment = appearance.textAlignment;//Alineamiento del texto
    customCell.cell.textLabel.textColor = appearance.unselectedTextColor;
    customCell.cell.textLabel.font = appearance.unselectedTextFont;
    customCell.cell.selectionStyle = UITableViewCellSelectionStyleNone;//Estilo de la celda
    customCell.cell.accessoryType = appearance.accesoryType;//Estilo de la celda
    customCell.cell.textLabel.backgroundColor = [UIColor clearColor];
    customCell.cell.textLabel.lineBreakMode = appearance.lineBreakMode;
    customCell.cell.textLabel.numberOfLines = appearance.numberOfLines;
    
    
    if (!appearance.backgroundView) {
        if (appearance.borderWidth != -57) {
            appearance.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 0)];
            appearance.backgroundView.opaque = NO;
            appearance.backgroundView.backgroundColor = appearance.unselectedColor;
            appearance.backgroundView.layer.borderWidth = appearance.borderWidth;
            appearance.backgroundView.layer.borderColor = [appearance.borderColor CGColor];
            appearance.backgroundView.layer.cornerRadius = appearance.cornerRadius;
            [customCell.cell setBackgroundView:appearance.backgroundView];
        }
    } else {
        appearance.unselectedColor = appearance.backgroundView.backgroundColor;
        [customCell.cell setBackgroundView:appearance.backgroundView];
    }
    //[customCell.cell setBackgroundView:appearance.backgroundView];
    if (appearance.heightCell <= 0) {
        appearance.heightCell = 44;
    }
    customCell.customCellAppearance = appearance;
    
    
}

/*-(CustomCell *) getNewCustomCell: (NSString *) cellText: (BOOL) selectionType {
 CustomCellAppearance * customCellappearance = APARIENCIAAULA;
 return [self getNewCustomCellWithAppearance:customCellappearance: cellText: selectionType];
 }
 
 -(CustomCell *) getNewCustomCell2: (NSString *) cellText: (BOOL) selectionType {
 CustomCellAppearance * customCellappearance = APARIENCIAELMUNDO;
 return [self getNewCustomCellWithAppearance:customCellappearance: cellText: selectionType];
 }
 
 -(CustomCell *) getNewCustomCell3: (NSString *) cellText: (BOOL) selectionType {
 CustomCellAppearance * customCellappearance = APARIENCIA3;
 return [self getNewCustomCellWithAppearance:customCellappearance: cellText: selectionType];
 }*/

@end
