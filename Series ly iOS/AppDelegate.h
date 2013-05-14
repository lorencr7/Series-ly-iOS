//
//  AppDelegate.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSplitViewController, DrawerViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) UISplitViewController *splitViewController;
@property (strong, nonatomic) CustomSplitViewController *splitViewController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) DrawerViewController *drawerViewController;

-(void) loadContentControllers;
-(void) loadLogInController;

@end
