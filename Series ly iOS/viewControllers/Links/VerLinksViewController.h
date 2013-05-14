//
//  ListadoLinksViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"

@class MediaElementUserPending, ListadoLinksViewController;
@interface VerLinksViewController : RootViewController

@property(strong,nonatomic) MediaElementUserPending * mediaElementUserPending;
@property(strong,nonatomic) ListadoLinksViewController * listadoLinksViewController;

- (id)initWithMediaElementUserPending: (MediaElementUserPending *) mediaElementUserPending;

@end
