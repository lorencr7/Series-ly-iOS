//
//  CustomCell.h
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CustomCellAppearance;
@interface CustomCell : NSObject

@property (strong,nonatomic,readwrite) UITableViewCell * cell;
@property (assign,nonatomic) BOOL isSelectable;
@property (strong,nonatomic,readwrite) CustomCellAppearance * customCellAppearance;
//Cambia el contenido del detail
-(void) executeAction: (UIViewController *) viewController;
-(id)initWithSelectionType: (BOOL) selectionType;
-(void)customSelect;
-(void)customDeselect;

@end
