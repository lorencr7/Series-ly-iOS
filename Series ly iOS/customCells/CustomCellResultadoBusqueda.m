//
//  CustomCellResultadoBusqueda.m
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 31/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellResultadoBusqueda.h"
#import "DetailViewController.h"
#import "VerDetalleElementSearchedViewController.h"
#import "DetalleElementViewController.h"

@implementation CustomCellResultadoBusqueda

- (id)initWithMediaElement: (MediaElement *) mediaElement{
    self = [super init];
    if (self) {
        self.mediaElement = mediaElement;
    }
    return self;
}

-(void) executeAction:(UIViewController *)viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        VerDetalleElementSearchedViewController * verDetalleElementViewController = [[VerDetalleElementSearchedViewController alloc] initWithMediaElement:self.mediaElement];
        /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            VerDetalleElementViewController * verDetalleElementViewController = [[VerDetalleElementViewController alloc] initWithMediaElement:self.mediaElement];
            [viewController.navigationController pushViewController:verDetalleElementViewController animated:YES];
        } else {
            DetalleElementViewController * detalleElementViewController = listadoElementsSiguiendoViewController.detalleElementViewController;
            [detalleElementViewController reloadInfoFromMediaElement:self.mediaElement];
        }*/
        [detailViewController.navigationController pushViewController:verDetalleElementViewController animated:YES];
    }
}

@end
