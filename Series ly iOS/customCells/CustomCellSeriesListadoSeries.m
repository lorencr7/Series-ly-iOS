//
//  CustomCellSeriesListadoSeries.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 10/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellSeriesListadoSeries.h"
#import "VerDetalleElementViewController.h"

@implementation CustomCellSeriesListadoSeries

- (id)initWithMediaElementUser: (MediaElementUser *) mediaElementUser {
    self = [super init];
    if (self) {
        self.mediaElementUser = mediaElementUser;
    }
    return self;
}

-(void) executeAction: (UIViewController *) viewController {
    
    VerDetalleElementViewController * verDetalleElementViewController = [[VerDetalleElementViewController alloc] initWithMediaElementUser:self.mediaElementUser];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [viewController.navigationController pushViewController:verDetalleElementViewController animated:YES];
    } else {
        //UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:linksViewController];
        //navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        //navigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
        //[viewController presentViewController:navigationController animated:YES completion:nil];
    }
}

@end
