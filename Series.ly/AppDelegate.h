//
//  AppDelegate.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSplitViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) CustomSplitViewController *splitViewController;


-(void) saveData;
-(void) loadContentControllers;

@end
