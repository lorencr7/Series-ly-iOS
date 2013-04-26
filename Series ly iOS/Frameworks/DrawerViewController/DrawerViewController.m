//
//  NotificationViewController.m
//  FI UPM
//
//  Created by Lorenzo Villarroel on 03/04/13.
//  Copyright (c) 2013 Laboratorio Ingeniería del Software. All rights reserved.
//

#import "DrawerViewController.h"

#define DRAWERVIEWWIDTH 250
#define NAVIGATIONBARHEIGHTLANDSCAPE 32

@interface DrawerViewController ()

@end

@implementation DrawerViewController


- (id)init {
    self = [super init];
    if (self) {
        panApplied = 0;
        self.buttons = [NSMutableArray array];
    }
    return self;
}

-(UIViewController *) getDrawerViewController {
    return [self.viewControllers objectAtIndex:0];
}

-(UIViewController *) getMainViewController {
    return [self.viewControllers objectAtIndex:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIViewController * drawerViewController;
    UIViewController * mainViewController;
   
    
    CGSize screenSize = [self currentSize];
    CGFloat screenHeight = screenSize.height;
    CGFloat screenWidth = screenSize.width;
    
    self.drawerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DRAWERVIEWWIDTH, screenHeight)];
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    
    
    self.drawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.mainView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    drawerViewController = [self.viewControllers objectAtIndex:0];
    drawerViewController.view.frame = self.drawerView.frame;
    
    mainViewController = [self.viewControllers objectAtIndex:1];
    mainViewController.view.frame = self.mainView.frame;
    
    if ([mainViewController class] == [UITabBarController class]) {//TabBarController
        UITabBarController * tabBarController = (UITabBarController *) mainViewController;
        for (UIViewController * viewController in tabBarController.viewControllers) {
            if ([viewController class] == [UINavigationController class]) {
                UINavigationController * navigationController = (UINavigationController *) viewController;
                UIViewController * rootViewController = [navigationController.viewControllers objectAtIndex:0];
                UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithTitle:@"D"
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                           action:@selector(showDrawer)];
                rootViewController.navigationItem.leftBarButtonItem = button;
                [self.buttons addObject:button];
                
            }
        }
    } else if ([mainViewController class] == [UINavigationController class]) {//NavigationController
        UINavigationController * navigationController = (UINavigationController *) mainViewController;
        UIViewController * rootViewController = [navigationController.viewControllers objectAtIndex:0];
        UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithTitle:@"D"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(showDrawer)];
        rootViewController.navigationItem.leftBarButtonItem = button;
        [self.buttons addObject:button];
    }
    
    [self.drawerView addSubview:drawerViewController.view];
    [self.mainView addSubview:mainViewController.view];
    
    [self configureGestures];
        
    [self.view addSubview:self.drawerView];
    [self.view addSubview:self.mainView];
}

-(void) configureGestures {
    
    self.oneFingerOneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDrawer)];
    // Set required taps and number of touches
    [self.oneFingerOneTap setNumberOfTapsRequired:1];
    [self.oneFingerOneTap setNumberOfTouchesRequired:1];
    
    self.oneFngerPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMoveAround:)];
    [self.oneFngerPan setMaximumNumberOfTouches:1];
    [self.oneFngerPan setMinimumNumberOfTouches:1];
    [self.oneFngerPan setDelegate:self];
    [self.mainView addGestureRecognizer:self.oneFngerPan];
}

-(void)panGestureMoveAround:(UIPanGestureRecognizer *)panGesture {
    
    CGPoint translation = [panGesture translationInView:self.view];
    
    if (translation.x > 0) {//Hacia la derecha
        if (panGesture.view.frame.origin.x < DRAWERVIEWWIDTH + 1) {
            CGRect frame = panGesture.view.frame;
            if ((frame.origin.x + translation.x) > DRAWERVIEWWIDTH + 1) {
                frame.origin.x = DRAWERVIEWWIDTH + 1;
            } else {
                frame.origin.x += translation.x;
            }
            panGesture.view.frame = frame;
            [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
        }
    } else {//Hacia la izquierda
        if (panGesture.view.frame.origin.x > 0) {
            CGRect frame = panGesture.view.frame;
            if ((frame.origin.x + translation.x) < 0) {
                frame.origin.x = 0;
            } else {
                frame.origin.x += translation.x;
            }
            panGesture.view.frame = frame;
            [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
        }
    }
    if (translation.x != 0) {
        panApplied = translation.x;
    }
    
    if ([panGesture state] == UIGestureRecognizerStateEnded) {
        if (panApplied > 0) {
            [self showDrawer];
        } else {
            [self hideDrawer];
        }
        panApplied = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showDrawer{
    for (UIBarButtonItem * button in self.buttons) {
        [button setAction:@selector(hideDrawer)];
    }
    [self.mainView addGestureRecognizer:self.oneFingerOneTap];
    CGRect frame = self.mainView.frame;
    frame.origin.x = DRAWERVIEWWIDTH + 1;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainView.frame = frame;
    } completion:^(BOOL finished){
        
    }];
}



-(void) hideDrawer{
    for (UIBarButtonItem * button in self.buttons) {
        [button setAction:@selector(showDrawer)];
    }
    [self.mainView removeGestureRecognizer:self.oneFingerOneTap];
    CGRect frame = self.mainView.frame;
    frame.origin.x = 0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainView.frame = frame;
    } completion:^(BOOL finished){

    }];
}

/*******************************************************************************
 Rotacion del UIView
 ******************************************************************************/

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    // Do any additional setup after loading the view.
    UIViewController * drawerViewController = [self.viewControllers objectAtIndex:0];
    UIViewController * mainViewController = [self.viewControllers objectAtIndex:1];

	//[super willAnimateRotationToInterfaceOrientation:orientation duration:duration];
    if ([mainViewController class] == [UITabBarController class]) {//TabBarController
        UITabBarController * tabBarController = (UITabBarController *) mainViewController;
        for (UIViewController * viewController in tabBarController.viewControllers) {
            if ([viewController class] == [UINavigationController class]) {
                UINavigationController * navigationController = (UINavigationController *) viewController;
                CGRect frame = navigationController.navigationBar.frame;
                if (UIInterfaceOrientationIsPortrait(orientation)) {
                    frame.size.height = 44;
                } else {
                    frame.size.height = NAVIGATIONBARHEIGHTLANDSCAPE;
                }
                navigationController.navigationBar.frame = frame;
            }
        }
    } else if ([mainViewController class] == [UINavigationController class]) {//NavigationController
        UINavigationController * navigationController = (UINavigationController *) mainViewController;
        CGRect frame = navigationController.navigationBar.frame;
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            frame.size.height = 44;
        } else {
            frame.size.height = NAVIGATIONBARHEIGHTLANDSCAPE;
        }
        navigationController.navigationBar.frame = frame;
    }
    if ([drawerViewController class] == [UINavigationController class]) {//NavigationController
        UINavigationController * navigationController = (UINavigationController *) drawerViewController;
        CGRect frame = navigationController.navigationBar.frame;
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            frame.size.height = 44;
        } else {
            frame.size.height = NAVIGATIONBARHEIGHTLANDSCAPE;
        }
        navigationController.navigationBar.frame = frame;
    }
    
    
}


-(CGSize) currentSize {
    return [self sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation {
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        size = CGSizeMake(size.height, size.width);
    }
    if (application.statusBarHidden == NO) {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    return size;
}

@end
