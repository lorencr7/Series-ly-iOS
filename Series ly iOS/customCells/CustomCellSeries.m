//
//  CustomCellSeries.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellSeries.h"
#import "MultimediaViewController.h"
#import "DetailViewController.h"

@implementation CustomCellSeries

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        //MultimediaViewControllerIpad * multimediaViewControllerIpad = [[MultimediaViewControllerIpad alloc] initWithSourceInformation:usuario.seriesFollowing Title:NSLocalizedString(@"TableViewSeriesCellText", nil)];
        MultimediaViewControllerIpad * multimediaViewControllerIpad = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewSeriesCellText", nil)];
        [detailViewController setDetailItem:multimediaViewControllerIpad];
    }
}

@end
