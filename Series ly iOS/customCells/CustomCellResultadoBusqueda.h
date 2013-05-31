//
//  CustomCellResultadoBusqueda.h
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 31/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCell.h"

@class MediaElement;
@interface CustomCellResultadoBusqueda : CustomCell

@property(strong, nonatomic) MediaElement * mediaElement;

- (id)initWithMediaElement: (MediaElement *) mediaElement;

@end
