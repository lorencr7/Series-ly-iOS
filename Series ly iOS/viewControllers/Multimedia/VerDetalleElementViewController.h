//
//  VerDetalleElementViewController.h
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 31/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"

@class MediaElement,DetalleElementViewController;
@interface VerDetalleElementViewController : RootViewController

@property(strong, nonatomic) DetalleElementViewController * detalleElementViewController;

@property(strong, nonatomic) MediaElement * mediaElement;

- (id)initWithMediaElement: (MediaElement *) mediaElement;

@end
