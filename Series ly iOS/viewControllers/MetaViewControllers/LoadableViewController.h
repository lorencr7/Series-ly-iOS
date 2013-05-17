//
//  LoadableViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadableViewController : UIViewController {
    UIActivityIndicatorView *activityIndicator;
}

@property(strong, nonatomic) NSMutableArray * requests;
@property(strong, nonatomic) NSMutableArray * threads;

-(void) iniciarActivityIndicator;
-(void) activateActivityIndicator;
-(void) stopActivityIndicator;

-(void) configureImageView: (NSMutableDictionary *) arguments;

-(void) loadData;
-(void) getData;


@end
