//
//  ListadoCapitulosPendientesViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>




@class CustomTableViewController;

typedef enum {
    SourceSeriesPendientes,
    SourcePeliculasPendientes,
    SourceTVShowsPendientes,
    SourceDocumentalesPendientes,
}TipoSourceData;

@interface ListadoCapitulosPendientesViewController : UIViewController


@property (strong, nonatomic) CustomTableViewController *tableViewEpisodios;
//@property (strong, nonatomic) UIView * viewEpisodios;
@property (assign, nonatomic) CGRect frame;
@property (strong, nonatomic) NSMutableArray * sourceData;
@property (assign, nonatomic) TipoSourceData tipoSourceData;

- (id)initWithFrame: (CGRect) frame SourceData: (TipoSourceData) sourceData;
- (void) fillTableViewFromSource: (NSMutableArray *) source;

@end
