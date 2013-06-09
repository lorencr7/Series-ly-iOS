//
//  CustomHeaderAppearance.h
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomHeaderFooterAppearance : NSObject

//@property (assign,nonatomic) double headerHeight;
@property (assign,nonatomic) CGRect labelFrame;
@property (strong,nonatomic) UIColor * labelBackgroundColor;
@property (strong,nonatomic) UIColor * labelTextColor;
@property (strong,nonatomic) UIFont * labelTextFont;
@property (assign,nonatomic) UITextAlignment labelTextAlignment;
@property (strong,nonatomic) UIColor * labelBorderColor;
@property (assign,nonatomic) double labelBorderWidth;
@property (assign,nonatomic) double labelBorderRadius;

- (id)initWithAppearance: (CGRect) labelFrame labelBackgroundColor: (UIColor*) labelBackgroundColor labelTextColor: (UIColor*) labelTextColor labelTextFont: (UIFont*) labelTextFont labelTextAlignment: (UITextAlignment) labelTextAlignment labelBorderColor: (UIColor*) labelBorderColor labelBorderWidth: (double) labelBorderWidth labelBorderRadius: (double) labelBorderRadius; 

@end
