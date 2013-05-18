//
//  ListadoLinksViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RootViewController.h"

@class MediaElement, ListadoLinksViewController;
@interface VerLinksViewController : RootViewController

@property(strong,nonatomic) MediaElement * mediaElement;
@property(strong,nonatomic) ListadoLinksViewController * listadoLinksViewController;

- (id)initWithMediaElement: (MediaElement *) mediaElement;

@end
