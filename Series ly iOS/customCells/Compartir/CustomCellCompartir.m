//
//  CustomCellCompartir.m
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 02/06/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellCompartir.h"
#import "UserCredentials.h"
#import "ManejadorServicioWebSeriesly.h"
#import "DetalleElementViewController.h"

@implementation CustomCellCompartir

- (id)initWithMediaElement: (MediaElement *) mediaElement {
    self = [super init];
    if (self) {
        self.mediaElement = mediaElement;
    }
    return self;
}

- (id)initWithMediaElement: (MediaElement *) mediaElement NewStatus: (int) newStatus{
    self = [super init];
    if (self) {
        self.mediaElement = mediaElement;
        self.newStatus = newStatus;
    }
    return self;
}

-(void) executeAction:(UIViewController *)viewController {
    [self performSelectorInBackground:@selector(changeStatus:) withObject:[NSNumber numberWithInt:self.newStatus]];
    if ([viewController class] == [DetalleElementViewController class]) {
        DetalleElementViewController * detalleElementViewController = (DetalleElementViewController *) viewController;
        if ([detalleElementViewController.popover isPopoverVisible]) {
            [detalleElementViewController.popover dismissPopoverAnimated:YES];
        }
    }
}

-(void) changeStatus: (NSNumber *) newStatus {
    UserCredentials * userCredentials = [UserCredentials getInstance];
    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    [manejadorServicioWeb updateMediaStatusWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken MediaElement:self.mediaElement Status:[newStatus intValue]];
}

@end
