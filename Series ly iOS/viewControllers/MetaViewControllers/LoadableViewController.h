//
//  LoadableViewController.h
//  FI UPM
//
//  Created by Lorenzo Villarroel on 14/05/13.
//  Copyright (c) 2013 Laboratorio Ingeniería del Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableViewController;
@interface LoadableViewController : UIViewController {
    UIActivityIndicatorView *activityIndicator;
}

@property (strong, nonatomic) CustomTableViewController *customTableView;
@property (strong, nonatomic) UITableViewController *tableViewController;

@property(strong, nonatomic) NSMutableArray * requests;
@property(strong, nonatomic) NSMutableArray * threads;

-(void) iniciarActivityIndicator;
-(void) stopActivityIndicator;

-(void) configureImageView: (NSMutableDictionary *) arguments;

-(void) reloadTableViewWithSections: (NSMutableArray *) sections;

@end
