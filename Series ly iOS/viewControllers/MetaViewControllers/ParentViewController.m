//
//  ParentViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 21/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentViewController ()

@end

@implementation ParentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
        [interstitialAd presentFromViewController:self];
    }
}

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    
}

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"interstitialAdError: %@",error.localizedDescription);
}

@end
