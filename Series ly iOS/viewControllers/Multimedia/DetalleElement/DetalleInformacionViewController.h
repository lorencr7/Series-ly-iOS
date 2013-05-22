//
//  DetalleInformacionViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 22/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"

@class FullInfo;
@interface DetalleInformacionViewController : LoadableViewController

@property(assign, nonatomic) CGRect frame;
@property(strong, nonatomic) FullInfo * fullInfo;

@property(assign, nonatomic) int altoContenidoScrollView;
@property(strong, nonatomic) UIScrollView * scrollView;

- (id)initWithFrame: (CGRect) frame FullInfo: (FullInfo *) fullInfo;


@end
