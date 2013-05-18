//
//  CustomCellMultimediaListadoCapitulos.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 18/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCell.h"

@class MediaElementUser,Pending;
@interface CustomCellMultimediaListadoCapitulos : CustomCell

@property(strong, nonatomic) MediaElementUser * mediaElementUser;
@property(strong, nonatomic) Pending * pending;


- (id)initWithMediaElementUser: (MediaElementUser *) mediaElementUser Pending: (Pending *) pending;

@end
