//
//  ElementosSeccion.h
//  CaptacionV
//
//  Created by Lorenzo Villarroel on 05/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionElement : NSObject

@property (strong,nonatomic,readwrite) NSString * sectionSubtitle;
@property (strong,nonatomic,readwrite) NSMutableArray * cells;

@property (nonatomic, readwrite, assign) CGFloat heightHeader;
@property (nonatomic, readwrite, assign) CGFloat heightFooter;

@property (strong, nonatomic) UILabel *labelHeader;
@property (strong, nonatomic) UILabel *labelFooter;


-(UIView *) getHeader;
-(UIView *) getFooter;
- (id)initWithHeightHeader: (double) heightHeader labelHeader: (UILabel*) labelHeader heightFooter: (double) heightFooter labelFooter: (UILabel*) labelFooter cells:(NSMutableArray*) cells;

@end
