//
//  CustomCellCompartir.m
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 02/06/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellCompartir.h"

@implementation CustomCellCompartir

- (id)initWithMediaElement: (MediaElement *) mediaElement {
    self = [super init];
    if (self) {
        self.mediaElement = mediaElement;
    }
    return self;
}

+ (id)CustomCellCompartirWithMediaElement: (MediaElement *) mediaElement {
    CustomCellCompartir * customCellCompartir = [[CustomCellCompartir alloc] initWithMediaElement:mediaElement];
    return customCellCompartir;
}

-(void) executeAction:(UIViewController *)viewController {
}

@end
