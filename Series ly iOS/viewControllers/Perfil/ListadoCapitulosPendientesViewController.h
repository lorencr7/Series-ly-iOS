//
//  ListadoCapitulosPendientesViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RefreshableAndDownloadableViewController.h"

typedef enum {
    SourceSeriesPendientes,
    SourcePeliculasPendientes,
    SourceTVShowsPendientes,
    SourceDocumentalesPendientes,
}TipoSourceData;

@class CustomTableViewController;
@interface ListadoCapitulosPendientesViewController : RefreshableAndDownloadableViewController


//@property (strong, nonatomic) CustomTableViewController *tableViewEpisodios;
@property (assign, nonatomic) CGRect frame;
@property (strong, nonatomic) NSMutableArray * sourceData;
@property (assign, nonatomic) TipoSourceData tipoSourceData;
@property (strong, nonatomic) NSMutableArray * lastSourceData;


- (id)initWithFrame: (CGRect) frame SourceData: (TipoSourceData) sourceData;
- (void) fillTableViewFromSource: (NSMutableArray *) source;

@end
