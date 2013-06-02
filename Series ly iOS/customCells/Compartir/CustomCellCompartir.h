//
//  CustomCellCompartir.h
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 02/06/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCell.h"

@class MediaElement;
@interface CustomCellCompartir : CustomCell

@property (strong, nonatomic) MediaElement * mediaElement;

- (id)initWithMediaElement: (MediaElement *) mediaElement;

+ (id)CustomCellCompartirWithMediaElement: (MediaElement *) mediaElement;

@end
