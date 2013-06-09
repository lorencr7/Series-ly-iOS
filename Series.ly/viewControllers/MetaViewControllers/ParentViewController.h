//
//  ParentViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 21/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ParentViewController : UIViewController <ADInterstitialAdDelegate, ADBannerViewDelegate>

@property (strong, nonatomic) ADInterstitialAd * interstitial;
@property (strong, nonatomic) ADBannerView *bannerView;


-(void) showInterstitialBanner;
- (void) showiADBanner;

@end
