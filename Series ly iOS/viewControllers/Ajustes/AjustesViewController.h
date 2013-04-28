//
//  AjustesViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableViewController;
@interface AjustesViewController : UIViewController

@property (strong, nonatomic) CustomTableViewController *tableViewAjustes;

-(void) loadListadoAjustesWithFrame: (CGRect) frame Sections: (NSMutableArray *) sections;
-(void) loadDetalleAjustesWithFrame: (CGRect) frame;
-(void) iniciarAutores;

@end

@interface AjustesViewControllerIpad : AjustesViewController

@property (strong, nonatomic) UIView * viewTableAjustes;

@property (strong, nonatomic) UIView * viewDetalleAjustes;

@end

@interface AjustesViewControllerIphone : AjustesViewController

@end
