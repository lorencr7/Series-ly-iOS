//
//  CustomCellPeliculas.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellPeliculas.h"
#import "DetailViewController.h"
#import "ListadoElementsSiguiendoViewController.h"
#import "PeliculasViewControllerIpad.h"
#import "PeliculasViewControllerIphone.h"

@implementation CustomCellPeliculas



-(void) executeAction: (UIViewController *) viewController {
    if ([viewController class] == [DetailViewController class]) {
        DetailViewController * detailViewController = (DetailViewController *) viewController;
        PeliculasViewController * peliculasViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            peliculasViewController = [[PeliculasViewControllerIphone alloc] init];
        } else {
            peliculasViewController = [[PeliculasViewControllerIpad alloc] init];
        }
        
        [detailViewController setDetailItem:peliculasViewController];
        /*DetailViewController * detailViewController = (DetailViewController *) viewController;
        MultimediaViewController * multimediaViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            multimediaViewController = [[MultimediaViewControllerIphone alloc] initWithTitle:NSLocalizedString(@"TableViewPeliculasCellText", nil)TipoSourceData:SourcePeliculasSiguiendo];
        } else {
            multimediaViewController = [[MultimediaViewControllerIpad alloc] initWithTitle:NSLocalizedString(@"TableViewPeliculasCellText", nil)TipoSourceData:SourcePeliculasSiguiendo];
        }
        
        [detailViewController setDetailItem:multimediaViewController];*/
    }
}

@end
