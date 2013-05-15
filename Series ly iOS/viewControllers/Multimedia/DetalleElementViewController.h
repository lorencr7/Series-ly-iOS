//
//  DetalleElementViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"

@class MediaElementUser, FullInfo;
@interface DetalleElementViewController : LoadableViewController

@property(assign, nonatomic) CGRect frame;
@property(strong, nonatomic) MediaElementUser * mediaElementUser;
@property(strong, nonatomic) FullInfo * fullInfo;

- (id)initWithFrame: (CGRect) frame MediaElementUser: (MediaElementUser *) mediaElementUser;


@end
