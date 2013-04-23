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
        //MultimediaViewControllerIpad * multimediaViewControllerIpad = [[MultimediaViewControllerIpad alloc] initWithSourceInformation:usuario.peliculasFollowing Title:NSLocalizedString(@"TableViewPeliculasCellText", nil)];
        MultimediaViewControllerIpad * multimediaViewControllerIpad = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewPeliculasCellText", nil)];
        [detailViewController setDetailItem:multimediaViewControllerIpad];
    }
}

@end
