//
//  VerDetalleElementViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"

@class MediaElementUser,DetalleElementViewController;
@interface VerDetalleElementViewController : RootViewController

@property(strong, nonatomic) DetalleElementViewController * detalleElementViewController;

@property(strong, nonatomic) MediaElementUser * mediaElementUser;

- (id)initWithMediaElementUser: (MediaElementUser *) mediaElementUser;

@end
