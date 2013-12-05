//
//  AppDelegate.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerLoginViewController.h"
#import "UserCredentials.h"
#import "ContainerPerfilViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self setAppAppearance];
    [self restoreData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * userToken = [defaults objectForKey:@"userToken"];
    
    if (!userToken) {
        [self loadLoginController];
    } else {
        [self loadContentControllers];
    }
    
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void) loadContentControllers {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self loadTabBarViewController];
    } else {
        [self loadSplitViewController];
    }
    [self.window makeKeyAndVisible];
}

-(void) loadLoginController {
    ContainerLoginViewController * loginViewController = [[ContainerLoginViewController alloc] init];;
    self.window.rootViewController = loginViewController;
    
}

-(void) loadTabBarViewController {
    
    ContainerPerfilViewController * containerPeopleViewController = [[ContainerPerfilViewController alloc] init];
    ContainerPerfilViewController * containerProfileViewController = [[ContainerPerfilViewController alloc] init];
    ContainerPerfilViewController * containerChatsViewController = [[ContainerPerfilViewController alloc] init];
    
    UINavigationController * navigationControllerGente = [[UINavigationController alloc] initWithRootViewController:containerPeopleViewController];
    UINavigationController * navigationControllerPerfil = [[UINavigationController alloc] initWithRootViewController:containerProfileViewController];
    UINavigationController * navigationControllerChats = [[UINavigationController alloc] initWithRootViewController:containerChatsViewController];
    
    
    
    [navigationControllerGente.tabBarItem setImage:TABBARPERFILTABUNSELECTED];
    [navigationControllerGente.tabBarItem setSelectedImage:TABBARPERFILTABSELECTED];
    
    [navigationControllerPerfil.tabBarItem setImage:TABBARPERFILTABUNSELECTED];
    [navigationControllerPerfil.tabBarItem setSelectedImage:TABBARPERFILTABSELECTED];
    
    [navigationControllerChats.tabBarItem setImage:TABBARPERFILTABUNSELECTED];
    [navigationControllerChats.tabBarItem setSelectedImage:TABBARPERFILTABSELECTED];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[navigationControllerGente, navigationControllerChats, navigationControllerPerfil];
    //self.tabBarController.tabBar.translucent = NO;
    
    //[self customizeInterface];
    
    self.window.rootViewController = self.tabBarController;
    
    //[self.tabBarController setDelegate:self];
    
}

-(void) loadSplitViewController {
    /*MasterViewController *masterViewController = [[MasterViewController alloc] init];
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    masterNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    detailNavigationController.navigationBar.tintColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    
    masterViewController.detailViewController = detailViewController;
    
    self.splitViewController = [[CustomSplitViewController alloc] init];
    self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
    
    self.window.rootViewController = self.splitViewController;*/
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self restoreData];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void) restoreData {
    UserCredentials * userCredentials = [UserCredentials getInstance];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    /*NSDictionary * dict = [prefs objectForKey:@"userCredentials"];
    UserCredentials * cred = [[UserCredentials alloc] initWithDictionary:dict];
    userCredentials.authToken = cred.authToken;
    userCredentials.userToken = cred.userToken;*/

    
    NSData * authTokenEncoded = [prefs objectForKey:@"authToken"];
    NSData * userTokenEncoded = [prefs objectForKey:@"userToken"];
    
    userCredentials.authToken = [NSKeyedUnarchiver unarchiveObjectWithData:authTokenEncoded];
    userCredentials.userToken = [NSKeyedUnarchiver unarchiveObjectWithData:userTokenEncoded];
    
    //NSLog(@"RestoreData: %@",userCredentials.authToken);
}

-(void) saveData {
    UserCredentials * userCredentials = [UserCredentials getInstance];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //[prefs setObject:[userCredentials getDictionary] forKey:@"userCredentials"];
    
    NSData * authTokenEncoded = [NSKeyedArchiver archivedDataWithRootObject:userCredentials.authToken];
    NSData * userTokenEncoded = [NSKeyedArchiver archivedDataWithRootObject:userCredentials.userToken];
    
    
    [prefs setObject:authTokenEncoded forKey:@"authToken"];
    [prefs setObject:userTokenEncoded forKey:@"userToken"];
    [prefs synchronize];
}

-(void) setAppAppearance {
    NSMutableDictionary * mutableDictionaryNavigation = [[NSMutableDictionary alloc] init];
    [mutableDictionaryNavigation setObject:NAVIGATIONBARFONTCOLOR forKey:NSForegroundColorAttributeName];
    [mutableDictionaryNavigation setObject:NAVIGATIONBARFONT forKey:NSFontAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:mutableDictionaryNavigation];
    [[UINavigationBar appearance] setTintColor:TOPCOLOR];
    [[UINavigationBar appearance] setBarTintColor:TOPCOLOR];
    [[UINavigationBar appearance] setBackgroundImage:NAVIGATIONBARIMAGE forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UIToolbar appearance] setBarTintColor:BOTTOMCOLOR];
    [[UIToolbar appearance] setTintColor:BOTTOMCOLOR];
    
    NSMutableDictionary * mutableDictionaryNormal = [[NSMutableDictionary alloc] init];
    [mutableDictionaryNormal setObject:TABBARFONTCOLORUNSELECTED forKey:NSForegroundColorAttributeName];
    [mutableDictionaryNormal setObject:TABBARFONTUNSELECTED forKey:NSFontAttributeName];
    NSMutableDictionary * mutableDictionaryPressed = [[NSMutableDictionary alloc] init];
    [mutableDictionaryPressed setObject:TABBARFONTCOLORSELECTED forKey:NSForegroundColorAttributeName];
    [mutableDictionaryPressed setObject:TABBARFONTSELECTED forKey:NSFontAttributeName];
    [[UITabBarItem appearance] setTitleTextAttributes:mutableDictionaryNormal forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:mutableDictionaryPressed forState:UIControlStateSelected];
    
    
    [[UITabBar appearance] setTintColor:BOTTOMCOLOR];
    [[UITabBar appearance] setBarTintColor:BOTTOMCOLOR];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:TABBARIMAGE];
    
    [[UIButton appearance] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    NSMutableDictionary * mutableDictionarySegmentedNormal = [[NSMutableDictionary alloc] init];
    [mutableDictionarySegmentedNormal setObject:SEGMENTEDCONTROLUNSELECTEDFONTCOLOR forKey:NSForegroundColorAttributeName];
    [mutableDictionarySegmentedNormal setObject:SEGMENTEDCONTROLUNSELECTEDFONT forKey:NSFontAttributeName];
    NSMutableDictionary * mutableDictionarySegmentedPressed = [[NSMutableDictionary alloc] init];
    [mutableDictionarySegmentedPressed setObject:SEGMENTEDCONTROLSELECTEDFONTCOLOR forKey:NSForegroundColorAttributeName];
    [mutableDictionarySegmentedPressed setObject:SEGMENTEDCONTROLSELECTEDFONT forKey:NSFontAttributeName];
    [[UISegmentedControl appearance]setTitleTextAttributes:mutableDictionarySegmentedNormal forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:  mutableDictionarySegmentedPressed forState:UIControlStateSelected];
    [[UISegmentedControl appearance] setTintColor:SEGMENTEDCONTROLTINTCOLOR];
    
}

@end
