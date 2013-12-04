//
//  ParentViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 21/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ParentViewController.h"
//#import "GAITracker.h"
//#import "GAIDictionaryBuilder.h"
//#import "GAIFields.h"

@interface ParentViewController ()

@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /*NSDictionary * params = [[[GAIDictionaryBuilder createAppView] set:self.title
                                        forKey:kGAIScreenName] build];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:params];*/
    //self.trackedViewName = self.title;
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //tracker sen
    //[tracker sendView:self.title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showiADBanner {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
        self.bannerView.delegate = self;
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    
}

-(void) showInterstitialBanner {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.interstitial = [[ADInterstitialAd alloc] init];
        self.interstitial.delegate = self;
    }
}

- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        //[interstitialAd presentFromViewController:self];
    }
}

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    
}

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"interstitialAdError: %@",error.localizedDescription);
}

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                        target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil];
    } else {
        // Just set the UIBarButtonItem as you would normally
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem, nil];
    } else {
        // Just set the UIBarButtonItem as you would normally
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
}

-(UIButton *) crearBarButtonBoton: (NSString *) image {
    UIImage *buttonImageFavorite = [UIImage imageNamed:image];
    UIButton *aButtonFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
    //UIEdgeInsets insets = UIEdgeInsetsMake(0, 9.0f, 0, 0);
    
    
    aButtonFavorite.bounds = CGRectMake(0.0, 0.0, 32, 32);
    [aButtonFavorite setImage:buttonImageFavorite forState:UIControlStateNormal];
    return aButtonFavorite;
}

@end
