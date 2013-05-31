//
//  CustomCellPerfilListadoCapitulos.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 07/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCell.h"

@class MediaElement;
@interface CustomCellPerfilListadoCapitulos : CustomCell

@property(strong, nonatomic) MediaElement * mediaElementUserPending;

- (id)initWithMediaElement: (MediaElement *) mediaElementUserPending;

@end
