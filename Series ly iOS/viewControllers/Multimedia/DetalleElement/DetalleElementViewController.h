//
//  DetalleElementViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"

@class MediaElement, FullInfo, CustomTableViewController, DetalleEnlacesViewController, DetalleInformacionViewController;
@interface DetalleElementViewController : LoadableViewController <UIActionSheetDelegate>

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

@property(strong, nonatomic) UIBarButtonItem *buttonCompartir;

@property(strong, nonatomic) UIPopoverController * popover;
@property(strong, nonatomic) UITableViewController * tableViewControllerPopover;
@property(strong, nonatomic) CustomTableViewController * tableViewPopover;

- (id)initWithFrame: (CGRect) frame MediaElement: (MediaElement *) mediaElement;

-(void) reloadInfoFromMediaElement: (MediaElement *) mediaElementUser;


@end

#define SELECTEDCOLORAPARIENCIAPOPOVERCOMPARTIR [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIAPOPOVERCOMPARTIR nil
#define TEXTSELECTEDCOLORAPARIENCIAPOPOVERCOMPARTIR nil
#define UNSELECTEDFONTAPARIENCIAPOPOVERCOMPARTIR nil
#define SELECTEDFONTAPARIENCIAPOPOVERCOMPARTIR nil
#define TEXTALIGNMENTPOPOVERCOMPARTIR 0
#define ACCESORYTYPEPOPOVERCOMPARTIR UITableViewCellAccessoryNone
#define LINEBREAKMODEPOPOVERCOMPARTIR 0
#define NUMBEROFLINESPOPOVERCOMPARTIR 0
#define ACCESORYVIEWPOPOVERCOMPARTIR nil
//#define CUSTOMHEIGHTCELLPOPOVERCOMPARTIR 80

#define APARIENCIAPOPOVERCOMPARTIR(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIAPOPOVERCOMPARTIR unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAPOPOVERCOMPARTIR selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAPOPOVERCOMPARTIR unselectedTextFont:UNSELECTEDFONTAPARIENCIAPOPOVERCOMPARTIR selectedTextFont:SELECTEDFONTAPARIENCIAPOPOVERCOMPARTIR textAlignment:TEXTALIGNMENTPOPOVERCOMPARTIR accesoryType:ACCESORYTYPEPOPOVERCOMPARTIR lineBreakMode:LINEBREAKMODEPOPOVERCOMPARTIR numberOfLines:NUMBEROFLINESPOPOVERCOMPARTIR accesoryView:ACCESORYVIEWPOPOVERCOMPARTIR backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]



