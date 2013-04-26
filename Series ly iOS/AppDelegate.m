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
    //User * usuario = [manejadorBaseDeDatosBackup cargarInformacionUsuario];
    if (oldUserCredentials) {
        UserCredentials * userCredentials = [UserCredentials getInstance];
        userCredentials.authToken = oldUserCredentials.authToken;
        userCredentials.userToken = oldUserCredentials.userToken;
        //[PerfilViewController setUserCredentials:userCredentials];
        [self loadContentControllers];
    } else {
        [self loadLogInController];
    }
    //[self loadLogInController];
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
    //[manejadorBaseDeDatosBackup borrarInformacionUsuario];
    //[manejadorBaseDeDatosBackup guardarInformacionUsuario:[PerfilViewController getUsuario]];
    [manejadorBaseDeDatosBackup borrarUserCredentials];
    //[manejadorBaseDeDatosBackup guardarUserCredentials:[PerfilViewController getUserCredentials]];
    [manejadorBaseDeDatosBackup guardarUserCredentials:[UserCredentials getInstance]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
    //[PerfilViewController setUsuario:[manejadorBaseDeDatosBackup cargarInformacionUsuario]];
    //[PerfilViewController setUserCredentials:[manejadorBaseDeDatosBackup cargarUserCredentials]];
    UserCredentials * oldUserCredentials = [manejadorBaseDeDatosBackup cargarUserCredentials];
    if (oldUserCredentials) {
        UserCredentials * userCredentials = [UserCredentials getInstance];
        userCredentials.authToken = oldUserCredentials.authToken;
        userCredentials.userToken = oldUserCredentials.userToken;
        //[PerfilViewController setUserCredentials:userCredentials];
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
        /*LogInViewController *logInViewController = [[LogInViewController alloc] init];
        self.window.rootViewController = logInViewController;
        [self.window makeKeyAndVisible];*/
    }
    [self.window makeKeyAndVisible];
    
}

-(void) loadContentControllers {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        /*MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPhone" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        self.window.rootViewController = self.navigationController;*/
        //[self loadTabBarController];
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
    detailNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
    
    masterViewController.detailViewController = detailViewController;
    
    //self.splitViewController = [[UISplitViewController alloc] init];
    self.drawerViewController = [[DrawerViewController alloc] init];
    //self.splitViewController.delegate = detailViewController;
    self.drawerViewController.viewControllers = @[masterNavigationController, detailNavigationController];
    
    self.window.rootViewController = self.drawerViewController;
}

-(void) loadSplitViewController {
    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPad" bundle:nil];
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    masterNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    detailNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
    
    masterViewController.detailViewController = detailViewController;
    
    //self.splitViewController = [[UISplitViewController alloc] init];
    self.splitViewController = [[CustomSplitViewController alloc] init];
    //self.splitViewController.delegate = detailViewController;
    self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
    
    self.window.rootViewController = self.splitViewController;
}

/*-(void) loadTabBarController {
    MultimediaViewController *multimediaViewController = [[MultimediaViewController alloc] init];
    PerfilViewControllerIphone * perfilViewController = [[PerfilViewControllerIphone alloc] init];
    AjustesViewControllerIphone *ajustesViewController = [[AjustesViewControllerIphone alloc] init];

    
    UINavigationController * navigationController1 = [[UINavigationController alloc] initWithRootViewController:multimediaViewController];
    UINavigationController * navigationController2 = [[UINavigationController alloc] initWithRootViewController:perfilViewController];
    UINavigationController * navigationController3 = [[UINavigationController alloc] initWithRootViewController:ajustesViewController];
    
    NSMutableDictionary * mutableDictionaryNormal = [[NSMutableDictionary alloc] init];
    [mutableDictionaryNormal setObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [mutableDictionaryNormal setObject:[UIFont systemFontOfSize:10] forKey:UITextAttributeFont];
    NSDictionary * dictionaryNormal = [NSDictionary dictionaryWithDictionary:mutableDictionaryNormal];
    
    NSMutableDictionary * mutableDictionaryPressed = [[NSMutableDictionary alloc] init];
    [mutableDictionaryPressed setObject:[UIColor colorWithRed:(169/255.0) green:(212/255.0) blue:(252/255.0) alpha:1] forKey:UITextAttributeTextColor];
    [mutableDictionaryPressed setObject:[UIFont systemFontOfSize:10] forKey:UITextAttributeFont];
    NSDictionary * dictionaryPressed = [NSDictionary dictionaryWithDictionary:mutableDictionaryPressed];
    
    [navigationController1.tabBarItem setTitleTextAttributes:dictionaryNormal forState:UIControlStateNormal];
    [navigationController1.tabBarItem setTitleTextAttributes:dictionaryPressed forState:UIControlStateSelected];
    
    [navigationController2.tabBarItem setTitleTextAttributes:dictionaryNormal forState:UIControlStateNormal];
    [navigationController2.tabBarItem setTitleTextAttributes:dictionaryPressed forState:UIControlStateSelected];
    
    [navigationController3.tabBarItem setTitleTextAttributes:dictionaryNormal forState:UIControlStateNormal];
    [navigationController3.tabBarItem setTitleTextAttributes:dictionaryPressed forState:UIControlStateSelected];
    
    navigationController1.navigationBar.tintColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    navigationController2.navigationBar.tintColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    navigationController3.navigationBar.tintColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    
    [navigationController1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:NSLocalizedString(@"iconNews", nil)] withFinishedUnselectedImage:[UIImage imageNamed:NSLocalizedString(@"iconNews", nil)]];
    [navigationController2.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:NSLocalizedString(@"iconProfile", nil)] withFinishedUnselectedImage:[UIImage imageNamed:NSLocalizedString(@"iconProfile", nil)]];
    [navigationController3.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:NSLocalizedString(@"iconSettings", nil)] withFinishedUnselectedImage:[UIImage imageNamed:NSLocalizedString(@"iconSettings", nil)]];
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    [self customizeInterface];
    
    self.tabBarController.viewControllers = @[navigationController1,navigationController2,navigationController3];
    [self.tabBarController setDelegate:self];
    
    self.window.rootViewController = self.tabBarController;
    //self.window.rootViewController = self.navigationController2;
}

- (void)customizeInterface {
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selection-tab.png"]];
}*/

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    /*if ([viewController.title isEqualToString:NSLocalizedString(@"NewsPageTitle", @"The string in the navigation bar")]) {
        [[ManejadorBaseDeDatosLogs getInstance] insertarBotonWithCodigo:@"4"];
    } else if([viewController.title isEqualToString:NSLocalizedString(@"SettingsPageTitle", @"The string in the navigation bar")]) {
        [[ManejadorBaseDeDatosLogs getInstance] insertarBotonWithCodigo:@"1"];
    } else if([viewController.title isEqualToString:NSLocalizedString(@"ProfilePageTitle", @"The string in the navigation bar")]) {
        [[ManejadorBaseDeDatosLogs getInstance] insertarBotonWithCodigo:@"14"];
    }*/
//}


@end
