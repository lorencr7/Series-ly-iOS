//
//  CustomCellSeriesListadoSeries.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 10/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellSeriesListadoSeries.h"
#import "VerDetalleElementViewController.h"
#import "ListadoElementsSiguiendoViewController.h"
#import "DetalleElementViewController.h"

@implementation CustomCellSeriesListadoSeries

- (id)initWithMediaElement: (MediaElement *) mediaElementUser {
    self = [super init];
    if (self) {
        self.mediaElementUser = mediaElementUser;
    }
    return self;
}

-(void) executeAction: (UIViewController *) viewController {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        VerDetalleElementViewController * verDetalleElementViewController = [[VerDetalleElementViewController alloc] initWithMediaElement:self.mediaElementUser];
        [viewController.navigationController pushViewController:verDetalleElementViewController animated:YES];
    } else {
        ListadoElementsSiguiendoViewController * listadoElementsSiguiendoViewController = (ListadoElementsSiguiendoViewController*) viewController;
        DetalleElementViewController * detalleElementViewController = listadoElementsSiguiendoViewController.detalleElementViewController;
        [detalleElementViewController reloadInfoFromMediaElement:self.mediaElementUser];
    }
}

@end
