//
//  ListadoElementsSiguiendoViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RefreshableAndDownloadableViewController.h"

typedef enum {
    SourceSeriesSiguiendo,
    SourcePeliculasSiguiendo,
    SourceTVShowsSiguiendo,
    SourceDocumentalesSiguiendo,
}TipoSourceDataSiguiendo;

@class CustomTableViewController;
@interface ListadoElementsSiguiendoViewController : RefreshableAndDownloadableViewController

@property (strong, nonatomic) CustomTableViewController *tableViewMultimedia;
//@property (strong, nonatomic) UIView * viewEpisodios;
@property (assign, nonatomic) CGRect frame;
@property (strong, nonatomic) NSMutableArray * sourceData;
@property (assign, nonatomic) TipoSourceDataSiguiendo tipoSourceData;
@property (strong, nonatomic) NSMutableArray * lastSourceData;


- (id)initWithFrame: (CGRect) frame SourceData: (TipoSourceDataSiguiendo) sourceData;

@end
