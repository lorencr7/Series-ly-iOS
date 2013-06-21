//
//  CustomCellLinksLink.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCell.h"

@class Link;
@interface CustomCellLinksLink : CustomCell

@property(strong,nonatomic) Link * link;

-(id) initWithLink: (Link *) link;

@end