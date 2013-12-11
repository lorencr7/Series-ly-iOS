//
//  MasterTableViewController.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 08/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoadableWithTableViewController.h"

@class DetailViewController;
@interface MasterTableViewController : LoadableWithTableViewController

@property(strong, nonatomic) DetailViewController * detailViewController;

- (id)initWithFrame:(CGRect)frame DetailViewController: (DetailViewController *) detailViewController;

@end


#define SELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
#define TEXTSELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
#define UNSELECTEDFONTAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
#define SELECTEDFONTAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
#define TEXTALIGNMENTMASTERTABLEVIEWMASTERTABLEVIEWIPHONE 0
#define ACCESORYTYPEMASTERTABLEVIEWMASTERTABLEVIEWIPHONE UITableViewCellAccessoryNone
#define LINEBREAKMODEMASTERTABLEVIEWMASTERTABLEVIEWIPHONE 0
#define NUMBEROFLINESMASTERTABLEVIEWMASTERTABLEVIEWIPHONE 0
#define ACCESORYVIEWMASTERTABLEVIEWMASTERTABLEVIEWIPHONE nil
//#define CUSTOMHEIGHTCELLMASTERTABLEVIEWMASTERTABLEVIEWIPHONE 80

#define APARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE(BACKGROUNDVIEW,HEIGHTCELL) [[CustomCellAppearance alloc] initWithAppearanceWithCustomBackgroundViewWithSelectedColor:SELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE unselectedTextFont:UNSELECTEDFONTAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE selectedTextFont:SELECTEDFONTAPARIENCIAMASTERTABLEVIEWMASTERTABLEVIEWIPHONE textAlignment:TEXTALIGNMENTMASTERTABLEVIEWMASTERTABLEVIEWIPHONE accesoryType:ACCESORYTYPEMASTERTABLEVIEWMASTERTABLEVIEWIPHONE lineBreakMode:LINEBREAKMODEMASTERTABLEVIEWMASTERTABLEVIEWIPHONE numberOfLines:NUMBEROFLINESMASTERTABLEVIEWMASTERTABLEVIEWIPHONE accesoryView:ACCESORYVIEWMASTERTABLEVIEWMASTERTABLEVIEWIPHONE backgroundView:BACKGROUNDVIEW heightCell:HEIGHTCELL]
