//
//  LinksViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableWithTableViewController.h"
@class MediaElement, CustomTableViewController, Links, FullInfo, MediaElement;
@interface ListadoLinksViewController : LoadableWithTableViewController

@property(strong,nonatomic) MediaElement * mediaElement;
@property(strong,nonatomic) MediaElement * mediaElementUserPending;

@property(strong,nonatomic) FullInfo * fullInfo;

@property(strong,nonatomic) UISegmentedControl * segmentedControl;
@property(assign,nonatomic) CGRect frame;

@property(assign,nonatomic) UINavigationItem * parentNavigationItem;

//@property(strong,nonatomic) CustomTableViewController * tableViewLinks;
//@property(strong,nonatomic) UIView * viewTableViewLinks;

@property(strong,nonatomic) Links * links;

- (id)initWithFrame: (CGRect) frame MediaElement: (MediaElement *) mediaElement NavigationItem: (UINavigationItem *) navigationItem;
@end


#define SELECTEDCOLORAPARIENCIALISTADOLINKS [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIALISTADOLINKS nil
#define TEXTSELECTEDCOLORAPARIENCIALISTADOLINKS nil
#define UNSELECTEDFONTAPARIENCIALISTADOLINKS nil
#define SELECTEDFONTAPARIENCIALISTADOLINKS nil
#define TEXTALIGNMENTLISTADOLINKS 0
#define ACCESORYTYPELISTADOLINKS UITableViewCellAccessoryNone
#define LINEBREAKMODELISTADOLINKS 0
#define NUMBEROFLINESLISTADOLINKS 0
#define ACCESORYVIEWLISTADOLINKS nil
//#define CUSTOMHEIGHTCELLLISTADOLINKS 80

#define APARIENCIALISTADOLINKS(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIALISTADOLINKS unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIALISTADOLINKS selectedTextColor:TEXTSELECTEDCOLORAPARIENCIALISTADOLINKS unselectedTextFont:UNSELECTEDFONTAPARIENCIALISTADOLINKS selectedTextFont:SELECTEDFONTAPARIENCIALISTADOLINKS textAlignment:TEXTALIGNMENTLISTADOLINKS accesoryType:ACCESORYTYPELISTADOLINKS lineBreakMode:LINEBREAKMODELISTADOLINKS numberOfLines:NUMBEROFLINESLISTADOLINKS accesoryView:ACCESORYVIEWLISTADOLINKS backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]