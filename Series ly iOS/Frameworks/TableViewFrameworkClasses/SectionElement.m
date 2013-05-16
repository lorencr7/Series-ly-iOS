//
//  ElementosSeccion.m
//  CaptacionV
//
//  Created by Lorenzo Villarroel on 05/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SectionElement.h"

@implementation SectionElement 

@synthesize cells = _cells;
//@synthesize tituloSeccion = _tituloSeccion;
@synthesize sectionSubtitle = _sectionSubtitle;

@synthesize heightHeader = _heightHeader;
//@synthesize heightCell = _heightCell;
@synthesize heightFooter = _heightFooter;

@synthesize labelHeader = _labelHeader;
@synthesize labelFooter = _labelFooter;


- (id)initWithHeightHeader: (double) heightHeader labelHeader: (UILabel*) labelHeader heightFooter: (double) heightFooter labelFooter: (UILabel*) labelFooter cells:(NSArray*) cells {
    self = [super init];
    if (self) {
        //self.labelHeader = [[UILabel alloc] init];
        //self.labelFooter = [[UILabel alloc] init];
        //self.cells = [NSMutableArray array];
        self.heightHeader = heightHeader;
        self.heightFooter = heightFooter;
        self.labelHeader = labelHeader;
        self.labelFooter = labelFooter;
        self.cells = cells;
    }
    return self;
}


-(UIView *) getHeader {
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, self.heightHeader+10)];
    [view addSubview:self.labelHeader];
    
    return view;
}

-(UIView *) getFooter {
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, self.heightHeader+10)];
    [view addSubview:self.labelFooter];
    
    return view;
}

-(BOOL) isEqual:(id)object {
    if ([object class] != [self class]) {
        return NO;
    }
    SectionElement * sectionElement = (SectionElement *) object;
    if (self.heightHeader == sectionElement.heightHeader
        && self.heightFooter == sectionElement.heightFooter
        && [self.labelHeader isEqual:sectionElement.labelHeader]
        && [self.labelFooter isEqual:sectionElement.labelFooter]
        && [self.cells isEqualToArray:sectionElement.cells]) {
        
    }
    
    return NO;
}

@end
