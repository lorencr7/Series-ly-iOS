//
//  DetailViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface DetailViewController : UIViewController <ADBannerViewDelegate>

@property (strong, nonatomic) UIViewController * detailItem;
@property (strong, nonatomic) ADBannerView *bannerView;


- (void)configureView;

- (void) showiADBanner;

@end
