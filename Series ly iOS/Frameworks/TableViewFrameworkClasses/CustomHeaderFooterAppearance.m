//
//  CustomHeaderAppearance.m
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomHeaderFooterAppearance.h"

@implementation CustomHeaderFooterAppearance

@synthesize labelFrame = _labelFrame;
@synthesize labelBackgroundColor = _labelBackgroundColor;
@synthesize labelTextColor = _labelTextColor;
@synthesize labelTextFont = _labelTextFont;
@synthesize labelTextAlignment = _labelTextAlignment;
@synthesize labelBorderColor = _labelBorderColor;
@synthesize labelBorderWidth = _labelBorderWidth;
@synthesize labelBorderRadius = _labelBorderRadius;

- (id)initWithAppearance: (CGRect) labelFrame labelBackgroundColor: (UIColor*) labelBackgroundColor labelTextColor: (UIColor*) labelTextColor labelTextFont: (UIFont*) labelTextFont labelTextAlignment: (UITextAlignment) labelTextAlignment labelBorderColor: (UIColor*) labelBorderColor labelBorderWidth: (double) labelBorderWidth labelBorderRadius: (double) labelBorderRadius {
    self = [super init];
    if (self) {
        self.labelFrame = labelFrame;
        self.labelBackgroundColor = labelBackgroundColor;
        self.labelTextColor = labelTextColor;
        self.labelTextFont = labelTextFont;
        self.labelTextAlignment = labelTextAlignment;
        self.labelBorderColor = labelBorderColor;
        self.labelBorderWidth = labelBorderWidth;
        self.labelBorderRadius = labelBorderRadius;
    }
    return self;
}

@end
