//
//  CustomCellMultimediaListadoCapitulos.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 18/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCell.h"

@class MediaElement,Pending;
@interface CustomCellMultimediaListadoCapitulos : CustomCell

@property(strong, nonatomic) MediaElement * mediaElementUser;
@property(strong, nonatomic) Pending * pending;


- (id)initWithMediaElement: (MediaElement *) mediaElementUser Pending: (Pending *) pending;

@end
