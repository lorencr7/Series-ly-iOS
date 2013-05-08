//
//  AppDelegate.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "ManejadorBaseDeDatosBackup.h"
#import "DetailViewController.h"
#import "LogInViewController.h"
#import "PerfilViewController.h"
#import "UserCredentials.h"
#import "CustomSplitViewController.h"
#import "MultimediaViewController.h"
#import "AjustesViewController.h"
#import "DrawerViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
    UserCredentials * oldUserCredentials = [manejadorBaseDeDatosBackup cargarUserCredentials];
    if (oldUserCredentials) {
        UserCredentials * userCredentials = [UserCredentials getInstance];
        userCredentials.authToken = oldUserCredentials.authToken;
        userCredentials.userToken = oldUserCredentials.userToken;
        [self loadContentControllers];
    } else {
        [self loadLogInController];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
    [manejadorBaseDeDatosBackup borrarUserCredentials];
    [manejadorBaseDeDatosBackup guardarUserCredentials:[UserCredentials getInstance]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
    UserCredentials * oldUserCredentials = [manejadorBaseDeDatosBackup cargarUserCredentials];
    if (oldUserCredentials) {
        UserCredentials * userCredentials = [UserCredentials getInstance];
        userCredentials.authToken = oldUserCredentials.authToken;
        userCredentials.userToken = oldUserCredentials.userToken;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) loadLogInController {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        LogInViewControllerIphone *logInViewController = [[LogInViewControllerIphone alloc] init];
        self.window.rootViewController = logInViewController;
    } else {
        LogInViewControllerIpad *logInViewController = [[LogInViewControllerIpad alloc] init];
        self.window.rootViewController = logInViewController;
    }
    [self.window makeKeyAndVisible];
    
}

-(void) loadContentControllers {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self loadDrawerViewController];
    } else {
        [self loadSplitViewController];
    }
    [self.window makeKeyAndVisible];
}

-(void) loadDrawerViewController {
    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPad" bundle:nil];
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    masterNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    detailNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    
    masterViewController.detailViewController = detailViewController;
    
    self.drawerViewController = [[DrawerViewController alloc] init];
    self.drawerViewController.viewControllers = @[masterNavigationController, detailNavigationController];
    
    self.window.rootViewController = self.drawerViewController;
}

-(void) loadSplitViewController {
    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPad" bundle:nil];
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    masterNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    detailNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    
    masterViewController.detailViewController = detailViewController;
    
    self.splitViewController = [[CustomSplitViewController alloc] init];
    self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
    
    self.window.rootViewController = self.splitViewController;
}

-(void) showInterstitialBanner {
    self.interstitial = [[ADInterstitialAd alloc] init];
    self.interstitial.delegate = self;
}

- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        [interstitialAd presentFromViewController:self.splitViewController];
    }
}

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    
}

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}






@end
