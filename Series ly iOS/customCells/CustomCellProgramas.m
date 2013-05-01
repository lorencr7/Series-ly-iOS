//
//  CustomCellProgramas.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellProgramas.h"
#import "MultimediaViewControllerIphone.h"
#import "MultimediaViewControllerIpad.h"
#import "DetailViewController.h"
#import "ListadoElementsSiguiendoViewController.h"

@implementation CustomCellProgramas

-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        MultimediaViewController * multimediaViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            multimediaViewController = [[MultimediaViewControllerIphone alloc] initWithTitle:NSLocalizedString(@"TableViewProgramasCellText", nil)TipoSourceData:SourceTVShowsSiguiendo];
        } else {
            multimediaViewController = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewProgramasCellText", nil)TipoSourceData:SourceTVShowsSiguiendo];
        }
        
        [detailViewController setDetailItem:multimediaViewController];
    }
}

@end
