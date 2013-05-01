//
//  CustomCellSeries.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellSeries.h"
#import "MultimediaViewControllerIphone.h"
#import "MultimediaViewControllerIpad.h"
#import "ListadoElementsSiguiendoViewController.h"

#import "DetailViewController.h"

@implementation CustomCellSeries

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        MultimediaViewController * multimediaViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            multimediaViewController = [[MultimediaViewControllerIphone alloc] initWithTitle:NSLocalizedString(@"TableViewSeriesCellText", nil) TipoSourceData:SourceSeriesSiguiendo];
        } else {
            multimediaViewController = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewSeriesCellText", nil) TipoSourceData:SourceSeriesSiguiendo];
        }
         
        [detailViewController setDetailItem:multimediaViewController];
    }
}

@end
