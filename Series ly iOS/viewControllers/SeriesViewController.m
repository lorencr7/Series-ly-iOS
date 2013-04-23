//
//  SeriesViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 10/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "SeriesViewController.h"
#import "ConstantsCustomSplitViewController.h"
#import "TVFramework.h"
#import <QuartzCore/QuartzCore.h>
#import "PerfilViewController.h"
#import "User.h"
#import "ManejadorServicioWebSeriesly.h"
#import "UserCredentials.h"
#import "MediaElementUser.h"
#import "Poster.h"
#import "CustomCellSeriesListadoSeries.h"

@implementation SeriesViewController

- (id)init {
    self = [super init];
    if (self) {
        //El title tiene que estar en el init, sino el tabBar del iPhone no coge el nombre de la ventana
        self.title = NSLocalizedString(@"TableViewSeriesCellText", nil);
    }
    return self;
}

@end

@implementation SeriesViewControllerIpad

@end


@implementation SeriesViewControllerIphone

@end

