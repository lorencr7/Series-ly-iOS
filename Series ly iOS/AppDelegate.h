//
//  AppDelegate.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class CustomSplitViewController, DrawerViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate ,ADInterstitialAdDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) UISplitViewController *splitViewController;
@property (strong, nonatomic) CustomSplitViewController *splitViewController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) DrawerViewController *drawerViewController;
@property (strong, nonatomic) ADInterstitialAd * interstitial;



-(void) loadContentControllers;
-(void) loadLogInController;

-(void) showInterstitialBanner;


@end
