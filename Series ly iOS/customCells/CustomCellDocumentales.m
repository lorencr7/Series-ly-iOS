//
//  CustomCellDocumentales.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellDocumentales.h"
#import "MultimediaViewController.h"
#import "DetailViewController.h"

@implementation CustomCellDocumentales

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        //MultimediaViewControllerIpad * multimediaViewControllerIpad = [[MultimediaViewControllerIpad alloc] initWithSourceInformation:usuario.documentalesFollowing Title:NSLocalizedString(@"TableViewDocumentalesCellText", nil)];
        MultimediaViewControllerIpad * multimediaViewControllerIpad = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewDocumentalesCellText", nil)];
        [detailViewController setDetailItem:multimediaViewControllerIpad];
    }
}

@end
