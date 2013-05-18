//
//  DetalleElementViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableWithTableViewController.h"

@class MediaElementUser, FullInfo, CustomTableViewController;
@interface DetalleElementViewController : LoadableWithTableViewController

@property(assign, nonatomic) CGRect frame;
@property(strong, nonatomic) MediaElementUser * mediaElementUser;
@property(strong, nonatomic) FullInfo * fullInfo;

@property(strong, nonatomic) UISegmentedControl * segmentedControl;
@property(assign, nonatomic) int altoContenidoScrollView;
@property(strong, nonatomic) UIScrollView * scrollView;

@property(strong, nonatomic) CustomTableViewController * customTableView;
@property(strong, nonatomic) UITableViewController * tableViewController;

@property(strong, nonatomic) UIButton * buttonVerEnlaces;

- (id)initWithFrame: (CGRect) frame MediaElementUser: (MediaElementUser *) mediaElementUser;

-(void) reloadInfoFromMediaElementUser: (MediaElementUser *) mediaElementUser;


@end

#define UNSELECTEDCOLORAPARIENCIALISTADOCAPITULOS [UIColor whiteColor]
#define SELECTEDCOLORAPARIENCIALISTADOCAPITULOS [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIALISTADOCAPITULOS [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(100/255.0) alpha:1]
#define TEXTSELECTEDCOLORAPARIENCIALISTADOCAPITULOS [UIColor whiteColor]
#define UNSELECTEDFONTAPARIENCIALISTADOCAPITULOS [UIFont systemFontOfSize:18.0]
#define SELECTEDFONTAPARIENCIALISTADOCAPITULOS [UIFont systemFontOfSize:18.0]
#define BORDERCOLORLISTADOCAPITULOS [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0]
#define BORDERWIDTHLISTADOCAPITULOS 0
#define CORNERRADIUSLISTADOCAPITULOS 0
#define TEXTALIGNMENTLISTADOCAPITULOS NSTextAlignmentLeft
#define ACCESORYTYPELISTADOCAPITULOS UITableViewCellAccessoryNone
#define LINEBREAKMODELISTADOCAPITULOS NSLineBreakByWordWrapping
#define NUMBEROFLINESLISTADOCAPITULOS 0
#define ACCESORYVIEWLISTADOCAPITULOS nil
#define HEIGHTCELLLISTADOCAPITULOS 47

#define APARIENCIALISTADOCAPITULOS [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIALISTADOCAPITULOS selectedColor:SELECTEDCOLORAPARIENCIALISTADOCAPITULOS unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIALISTADOCAPITULOS selectedTextColor:TEXTSELECTEDCOLORAPARIENCIALISTADOCAPITULOS unselectedTextFont:UNSELECTEDFONTAPARIENCIALISTADOCAPITULOS selectedTextFont:SELECTEDFONTAPARIENCIALISTADOCAPITULOS borderColor:BORDERCOLORLISTADOCAPITULOS borderWidth:BORDERWIDTHLISTADOCAPITULOS cornerRadius:CORNERRADIUSLISTADOCAPITULOS textAlignment:TEXTALIGNMENTLISTADOCAPITULOS accesoryType:ACCESORYTYPELISTADOCAPITULOS lineBreakMode:LINEBREAKMODELISTADOCAPITULOS numberOfLines:NUMBEROFLINESLISTADOCAPITULOS accesoryView:ACCESORYVIEWLISTADOCAPITULOS heightCell:HEIGHTCELLLISTADOCAPITULOS]

#define LABELFRAMELISTADOCAPITULOSTITULO(x,y,w,h) CGRectMake(x, y, w, h)
#define LABELBACKGROUNDCOLORLISTADOCAPITULOSTITULO [UIColor whiteColor]
#define LABELTEXTCOLORLISTADOCAPITULOSTITULO [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(100/255.0) alpha:1]
#define LABELTEXTLISTADOCAPITULOSTITULO(texto) texto
#define LABELTEXTFONTLISTADOCAPITULOSTITULO [UIFont boldSystemFontOfSize:16.0]
#define LABELTEXTALIGNMENTLISTADOCAPITULOSTITULO NSTextAlignmentLeft
#define LABELBORDERCOLORLISTADOCAPITULOSTITULO [UIColor colorWithRed:(215.0/255.0) green:(214.0/255.0) blue:(211.0/255.0) alpha:1.0]
#define LABELBORDERWIDTHLISTADOCAPITULOSTITULO 0
#define LABELBORDERRADIUSLISTADOCAPITULOSTITULO 0

#define HEADERLISTADOCAPITULOSTITULO(x,y,w,h) [[CustomHeaderFooterAppearance alloc] initWithAppearance:LABELFRAMELISTADOCAPITULOSTITULO(x,y,w,h) labelBackgroundColor:LABELBACKGROUNDCOLORLISTADOCAPITULOSTITULO labelTextColor:LABELTEXTCOLORLISTADOCAPITULOSTITULO labelTextFont:LABELTEXTFONTLISTADOCAPITULOSTITULO labelTextAlignment:LABELTEXTALIGNMENTLISTADOCAPITULOSTITULO labelBorderColor:LABELBORDERCOLORLISTADOCAPITULOSTITULO labelBorderWidth:LABELBORDERWIDTHLISTADOCAPITULOSTITULO labelBorderRadius:LABELBORDERRADIUSLISTADOCAPITULOSTITULO]

