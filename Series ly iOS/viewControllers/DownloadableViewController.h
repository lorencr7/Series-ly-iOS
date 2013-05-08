//
//  DownloadableViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 08/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadableViewController : UIViewController

@property(strong, nonatomic) UIActivityIndicatorView * activityIndicatorView;

-(void) iniciarActivityIndicator;

@end
