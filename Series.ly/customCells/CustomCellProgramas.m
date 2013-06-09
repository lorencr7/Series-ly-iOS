//
//  CustomCellProgramas.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellProgramas.h"
#import "ProgramasViewControllerIpad.h"
#import "ProgramasViewControllerIphone.h"
#import "DetailViewController.h"
#import "ListadoElementsSiguiendoViewController.h"

@implementation CustomCellProgramas

-(void) executeAction: (UIViewController *) viewController {
    DetailViewController * detailViewController = (DetailViewController *) viewController;
    ProgramasViewController * programasViewController;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        programasViewController = [[ProgramasViewControllerIphone alloc] init];
    } else {
        programasViewController = [[ProgramasViewControllerIpad alloc] init];
    }
    
    [detailViewController setDetailItem:programasViewController];
    /*if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        MultimediaViewController * multimediaViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            multimediaViewController = [[MultimediaViewControllerIphone alloc] initWithTitle:NSLocalizedString(@"TableViewProgramasCellText", nil)TipoSourceData:SourceTVShowsSiguiendo];
        } else {
            multimediaViewController = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewProgramasCellText", nil)TipoSourceData:SourceTVShowsSiguiendo];
        }
        
        [detailViewController setDetailItem:multimediaViewController];
    }*/
}

@end
