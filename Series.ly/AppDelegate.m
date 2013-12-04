//
//  AppDelegate.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerLoginViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self setAppAppearance];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * userToken = [defaults objectForKey:@"userToken"];
    
    if (!userToken) {
        [self loadLoginController];
    } else {
        
    }
    
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) loadLoginController {
    ContainerLoginViewController * loginViewController = [[ContainerLoginViewController alloc] init];;
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        loginViewController = [[ContainerLoginiPhoneViewController alloc] init];
    } else {
        loginViewController = [[ContainerLoginiPadViewController alloc] init];
    }*/
    self.window.rootViewController = loginViewController;
    //[self.window makeKeyAndVisible];
    
}

-(void) restoreData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * authToken = [defaults objectForKey:@"authToken"];
    NSString * userToken = [defaults objectForKey:@"userToken"];
    NSLog(@"%@,%@",authToken,userToken);
    /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userEncoded = [prefs objectForKey:@"user"];
    User * user = [NSKeyedUnarchiver unarchiveObjectWithData:userEncoded];
    NSLog(@"token = %@, email = %@",user.credential.token,user.credential.email);
    [User setInstance:user];*/
}

-(void) saveData {
    /*User * user = [User getInstance];
    NSData *userEncoded = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:userEncoded forKey:@"user"];
    [prefs synchronize];*/
}

-(void) setAppAppearance {
    NSMutableDictionary * mutableDictionaryNavigation = [[NSMutableDictionary alloc] init];
    [mutableDictionaryNavigation setObject:NAVIGATIONBARFONTCOLOR forKey:NSForegroundColorAttributeName];
    [mutableDictionaryNavigation setObject:NAVIGATIONBARFONT forKey:NSFontAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:mutableDictionaryNavigation];
    [[UINavigationBar appearance] setTintColor:NAVIGATIONTINTCOLOR];
    [[UINavigationBar appearance] setBarTintColor:NAVIGATIONBARCOLOR];
    [[UINavigationBar appearance] setBackgroundImage:NAVIGATIONBARIMAGE forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UIToolbar appearance] setBarTintColor:BOTTOMCOLOR];
    [[UIToolbar appearance] setTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary * mutableDictionaryNormal = [[NSMutableDictionary alloc] init];
    [mutableDictionaryNormal setObject:TABBARFONTCOLORUNSELECTED forKey:NSForegroundColorAttributeName];
    [mutableDictionaryNormal setObject:TABBARFONTUNSELECTED forKey:NSFontAttributeName];
    NSMutableDictionary * mutableDictionaryPressed = [[NSMutableDictionary alloc] init];
    [mutableDictionaryPressed setObject:TABBARFONTCOLORSELECTED forKey:NSForegroundColorAttributeName];
    [mutableDictionaryPressed setObject:TABBARFONTSELECTED forKey:NSFontAttributeName];
    [[UITabBarItem appearance] setTitleTextAttributes:mutableDictionaryNormal forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:mutableDictionaryPressed forState:UIControlStateSelected];
    
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:PURPLECOLOR];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
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
