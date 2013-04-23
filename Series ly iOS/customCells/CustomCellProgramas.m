//
//  CustomCellProgramas.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellProgramas.h"
#import "MultimediaViewController.h"
#import "DetailViewController.h"

@implementation CustomCellProgramas

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        //MultimediaViewControllerIpad * multimediaViewControllerIpad = [[MultimediaViewControllerIpad alloc] initWithSourceInformation:usuario.tvShowsFollowing Title:NSLocalizedString(@"TableViewProgramasCellText", nil)];
        MultimediaViewControllerIpad * multimediaViewControllerIpad = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewProgramasCellText", nil)];
        [detailViewController setDetailItem:multimediaViewControllerIpad];
    }
}

@end
