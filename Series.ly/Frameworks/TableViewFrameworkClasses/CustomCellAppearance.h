//
//  CustomCellAppearance.h
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomCellAppearance : NSObject 

@property (strong,nonatomic) UIColor * unselectedColor;
@property (strong,nonatomic) UIColor * selectedColor;
@property (strong,nonatomic) UIColor * unselectedTextColor;
@property (strong,nonatomic) UIColor * selectedTextColor; 
@property (strong,nonatomic) UIFont * unselectedTextFont;
@property (strong,nonatomic) UIFont * selectedTextFont;
@property (strong,nonatomic) UIColor * borderColor;
@property (assign,nonatomic) double borderWidth;
@property (assign,nonatomic) double cornerRadius;
@property (assign,nonatomic) NSTextAlignment textAlignment;
@property (assign,nonatomic) UITableViewCellAccessoryType accesoryType;
@property (assign,nonatomic) NSLineBreakMode lineBreakMode;
@property (assign,nonatomic) int numberOfLines;
@property (strong,nonatomic) UIView * accesoryView;
@property (strong,nonatomic) UIView * backgroundView;
@property (assign,nonatomic) double heightCell;

- (id)initWithAppearanceWithUnselectedColor: (UIColor * ) unselectedColor selectedColor: (UIColor*) selectedColor unselectedTextColor: (UIColor*) unselectedTextColor selectedTextColor: (UIColor*) selectedTextColor unselectedTextFont: (UIFont *) unselectedTextFont selectedTextFont: (UIFont *) selectedTextFont borderColor: (UIColor * ) borderColor borderWidth: (double) borderWidth cornerRadius: (double) cornerRadius textAlignment: (NSTextAlignment) textAlignment accesoryType: (UITableViewCellAccessoryType) accesoryType lineBreakMode: (NSLineBreakMode) lineBreakMode numberOfLines: (int) numberOfLines accesoryView: (UIView *) accesoryView heightCell: (double) heightCell;

- (id)initWithAppearanceWithCustomBackgroundViewWithSelectedColor:(UIColor*) selectedColor unselectedTextColor: (UIColor*) unselectedTextColor selectedTextColor: (UIColor*) selectedTextColor unselectedTextFont: (UIFont *) unselectedTextFont selectedTextFont: (UIFont *) selectedTextFont textAlignment: (NSTextAlignment) textAlignment accesoryType: (UITableViewCellAccessoryType) accesoryType lineBreakMode: (NSLineBreakMode) lineBreakMode numberOfLines: (int) numberOfLines accesoryView: (UIView *) accesoryView backgroundView:(UIView *) backgroundView heightCell: (double) heightCell;

@end
