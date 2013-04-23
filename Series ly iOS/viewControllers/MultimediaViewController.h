//
//  MultimediaViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableViewController;
@interface MultimediaViewController : UIViewController

@end

@interface MultimediaViewControllerIpad : MultimediaViewController

@property (strong, nonatomic) UIView * viewListadoSeries;
@property (strong, nonatomic) CustomTableViewController * tableViewListadoSeries;

@property (strong, nonatomic) UIView * viewDetalleSeries;
@property (strong, nonatomic) CustomTableViewController * tableViewListadoCapitulos;

@property (strong, nonatomic) NSMutableArray * sourceInformation;

//- (id)initWithSourceInformation: (NSMutableArray *) sourceInformation Title: (NSString *) title;
- (id)initWithTitle: (NSString *) title;

-(void) loadData;
-(void) loadListadoSeries;
-(void) loadDetalleSeries;
-(void) configureUserInfo;
-(void) fillTableViewListadoWithSource: (NSMutableArray *) source ;


@end


@interface MultimediaViewControllerIphone : MultimediaViewController

@end

