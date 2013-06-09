//
//  ElementosSeccion.h
//  CaptacionV
//
//  Created by Lorenzo Villarroel on 05/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionElement : NSObject {
    /*@private
    NSString * tituloSeccion;//Titulo de la seccion correspondiente
    NSString * subtituloSeccion;//Titulo de la seccion correspondiente
    NSMutableArray * celdas;//Array de celdaCap de la seccion*/
}

//@property (strong,nonatomic,readwrite) NSString * tituloSeccion;
@property (strong,nonatomic,readwrite) NSString * sectionSubtitle;
@property (strong,nonatomic,readwrite) NSArray * cells;

@property (nonatomic, readwrite, assign) CGFloat heightHeader;
//@property (nonatomic, readwrite, assign) CGFloat heightCell;
@property (nonatomic, readwrite, assign) CGFloat heightFooter;

@property (strong, nonatomic) UILabel *labelHeader;
@property (strong, nonatomic) UILabel *labelFooter;


-(UIView *) getHeader;
-(UIView *) getFooter;
- (id)initWithHeightHeader: (double) heightHeader labelHeader: (UILabel*) labelHeader heightFooter: (double) heightFooter labelFooter: (UILabel*) labelFooter cells:(NSArray*) cells;

@end
