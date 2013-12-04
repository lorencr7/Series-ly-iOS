//
//  CustomCell.m
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"
#import "CustomCellAppearance.h"



@implementation CustomCell

@synthesize cell = _cell;
@synthesize isSelectable = _isSelectable;
@synthesize customCellAppearance = _customCellAppearance;

- (id)initWithSelectionType: (BOOL) selectionType {
    self = [super init];
    if (self) {
        self.isSelectable = selectionType;
    }
    return self;
}

-(void) executeAction: (UIViewController *) viewController {
    ////NSLog(@"CustomCell básico pulsado");
}

-(void)customSelect {
    self.cell.backgroundView.backgroundColor = self.customCellAppearance.selectedColor;
    self.cell.textLabel.textColor = self.customCellAppearance.selectedTextColor;
    self.cell.textLabel.font = self.customCellAppearance.selectedTextFont;
}

-(void)customDeselect {
    self.cell.backgroundView.backgroundColor = self.customCellAppearance.unselectedColor;
    self.cell.textLabel.textColor = self.customCellAppearance.unselectedTextColor;
    self.cell.textLabel.font = self.customCellAppearance.unselectedTextFont;
}

-(void) deleteCell:(UIViewController *) viewController {
    
}


@end
