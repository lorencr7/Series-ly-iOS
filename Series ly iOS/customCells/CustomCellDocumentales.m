//
//  CustomCellDocumentales.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellDocumentales.h"
#import "DocumentalesViewControllerIpad.h"
#import "DocumentalesViewControllerIphone.h"
#import "DetailViewController.h"
#import "ListadoElementsSiguiendoViewController.h"

@implementation CustomCellDocumentales

-(void) executeAction: (UIViewController *) viewController {
    DetailViewController * detailViewController = (DetailViewController *) viewController;
    DocumentalesViewController * documentalesViewController;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        documentalesViewController = [[DocumentalesViewControllerIphone alloc] init];
    } else {
        documentalesViewController = [[DocumentalesViewControllerIpad alloc] init];
    }
    
    [detailViewController setDetailItem:documentalesViewController];
    /*if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        MultimediaViewController * multimediaViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            multimediaViewController = [[MultimediaViewControllerIphone alloc] initWithTitle:NSLocalizedString(@"TableViewDocumentalesCellText", nil)TipoSourceData:SourceDocumentalesSiguiendo];
        } else {
            multimediaViewController = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewDocumentalesCellText", nil) TipoSourceData:SourceDocumentalesSiguiendo];
        }
        
        [detailViewController setDetailItem:multimediaViewController];
    }*/
}

@end
