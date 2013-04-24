//
//  CustomCellPeliculas.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPeliculas.h"
#import "MultimediaViewController.h"
#import "DetailViewController.h"

@implementation CustomCellPeliculas



-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        MultimediaViewController * multimediaViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            multimediaViewController = [[MultimediaViewControllerIphone alloc] initWithTitle:NSLocalizedString(@"TableViewPeliculasCellText", nil)];
        } else {
            multimediaViewController = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewPeliculasCellText", nil)];
        }
        
        [detailViewController setDetailItem:multimediaViewController];
    }
}

@end
