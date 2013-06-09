//
//  CustomCellAppearance.m
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCellAppearance.h"

@implementation CustomCellAppearance

@synthesize selectedColor = _selectedColor;
@synthesize unselectedColor = _unselectedColor;
@synthesize selectedTextColor = _selectedTextColor;
@synthesize unselectedTextColor = _unselectedTextColor;
@synthesize selectedTextFont = _selectedTextFont;
@synthesize unselectedTextFont = _unselectedTextFont;
@synthesize borderColor = _borderColor;
@synthesize borderWidth = _borderWidth;
@synthesize cornerRadius = _cornerRadius;
@synthesize textAlignment = _textAlignment;
@synthesize accesoryType = _accesoryType;
@synthesize lineBreakMode = _lineBreakMode;
@synthesize numberOfLines = _numberOfLines;
@synthesize accesoryView = _accesoryView;
@synthesize backgroundView = _backgroundView;
@synthesize heightCell = _heightCell;

- (id)initWithAppearanceWithUnselectedColor: (UIColor * ) unselectedColor selectedColor: (UIColor*) selectedColor unselectedTextColor: (UIColor*) unselectedTextColor selectedTextColor: (UIColor*) selectedTextColor unselectedTextFont: (UIFont *) unselectedTextFont selectedTextFont: (UIFont *) selectedTextFont borderColor: (UIColor * ) borderColor borderWidth: (double) borderWidth cornerRadius: (double) cornerRadius textAlignment: (UITextAlignment) textAlignment accesoryType: (UITableViewCellAccessoryType) accesoryType lineBreakMode: (UILineBreakMode) lineBreakMode numberOfLines: (int) numberOfLines accesoryView: (UIView *) accesoryView heightCell: (double) heightCell{
    self = [super init];
    if (self) {
        self.selectedColor = selectedColor;
        self.unselectedColor = unselectedColor;
        self.unselectedTextColor = unselectedTextColor;
        self.selectedTextColor = selectedTextColor;
        self.selectedTextFont = selectedTextFont;
        self.unselectedTextFont = unselectedTextFont;
        self.borderColor = borderColor;
        self.borderWidth = borderWidth;
        self.cornerRadius = cornerRadius;
        self.textAlignment = textAlignment;
        self.accesoryType = accesoryType;
        self.lineBreakMode = lineBreakMode;
        self.numberOfLines = numberOfLines;
        self.accesoryView = accesoryView;
        self.backgroundView = nil;
        self.heightCell = heightCell;
    }
    return self;
}

- (id)initWithAppearanceWithCustomBackgroundViewWithSelectedColor:(UIColor*) selectedColor unselectedTextColor: (UIColor*) unselectedTextColor selectedTextColor: (UIColor*) selectedTextColor unselectedTextFont: (UIFont *) unselectedTextFont selectedTextFont: (UIFont *) selectedTextFont textAlignment: (UITextAlignment) textAlignment accesoryType: (UITableViewCellAccessoryType) accesoryType lineBreakMode: (UILineBreakMode) lineBreakMode numberOfLines: (int) numberOfLines accesoryView: (UIView *) accesoryView backgroundView:(UIView *) backgroundView heightCell: (double) heightCell {
    self = [super init];
    if (self) {
        self.selectedColor = selectedColor;
        self.unselectedTextColor = unselectedTextColor;
        self.selectedTextColor = selectedTextColor;
        self.selectedTextFont = selectedTextFont;
        self.unselectedTextFont = unselectedTextFont;
        self.textAlignment = textAlignment;
        self.accesoryType = accesoryType;
        self.lineBreakMode = lineBreakMode;
        self.numberOfLines = numberOfLines;
        self.accesoryView = accesoryView;
        self.backgroundView = backgroundView;
        self.heightCell = heightCell;
    }
    return self;
}


@end
