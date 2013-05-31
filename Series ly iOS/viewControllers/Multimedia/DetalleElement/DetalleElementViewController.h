//
//  DetalleElementViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"

@class MediaElement, FullInfo, CustomTableViewController, DetalleEnlacesViewController, DetalleInformacionViewController;
@interface DetalleElementViewController : LoadableViewController

@property(assign, nonatomic) CGRect frame;
@property(strong, nonatomic) MediaElement * mediaElement;
@property(strong, nonatomic) FullInfo * fullInfo;

@property(strong, nonatomic) DetalleEnlacesViewController * detalleEnlacesViewController;
@property(strong, nonatomic) DetalleInformacionViewController * detalleInformacionViewController;


@property(strong, nonatomic) UISegmentedControl * segmentedControl;
//@property(assign, nonatomic) int altoContenidoScrollView;
//@property(strong, nonatomic) UIScrollView * scrollView;

//@property(strong, nonatomic) CustomTableViewController * customTableView;
//@property(strong, nonatomic) UITableViewController * tableViewController;

@property(strong, nonatomic) UIButton * buttonVerEnlaces;

-(void) hola;

- (id)initWithFrame: (CGRect) frame MediaElement: (MediaElement *) mediaElement;

-(void) reloadInfoFromMediaElement: (MediaElement *) mediaElementUser;


@end



