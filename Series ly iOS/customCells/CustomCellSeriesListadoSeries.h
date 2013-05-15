//
//  CustomCellSeriesListadoSeries.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 10/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCell.h"

@class MediaElementUser;
@interface CustomCellSeriesListadoSeries : CustomCell

@property(strong, nonatomic) MediaElementUser * mediaElementUser;

- (id)initWithMediaElementUser: (MediaElementUser *) mediaElementUser;

@end
