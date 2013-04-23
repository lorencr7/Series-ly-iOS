//
//  FabricaTitulosSecciones.m
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FabricaHeaderFooterSecciones.h"
#import "CustomHeaderFooterAppearance.h"
#import <QuartzCore/QuartzCore.h>

static FabricaHeaderFooterSecciones * instance;

@implementation FabricaHeaderFooterSecciones

+(FabricaHeaderFooterSecciones *) getInstance {
    if (instance == nil) {
        instance = [[FabricaHeaderFooterSecciones alloc] init];
        
    }
    return instance;
}

-(UILabel *) getNewTitleLabelWithTitle: (NSString *) title appearance: (CustomHeaderFooterAppearance *) appearance {
    UILabel * label = [[UILabel alloc] initWithFrame:appearance.labelFrame];
    label.backgroundColor = appearance.labelBackgroundColor;
    label.textColor = appearance.labelTextColor;
    label.font = appearance.labelTextFont;
    label.textAlignment = appearance.labelTextAlignment;
    label.layer.borderColor = [appearance.labelBorderColor CGColor];
    label.layer.borderWidth = appearance.labelBorderWidth;
    label.layer.cornerRadius = appearance.labelBorderRadius;
    label.text = title;
    return label;
     
}

@end
