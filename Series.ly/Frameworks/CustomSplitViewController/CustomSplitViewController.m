//
//  CustomSplitViewController.m
//  CustomSplitView
//
//  Created by lorenzo villarroel perez on 31/12/11.
//  Copyright (c) 2011 Politecnica de Madrid. All rights reserved.
//

#import "CustomSplitViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ConstantsCustomSplitViewController.h"


static CustomSplitViewController * controller;

@implementation CustomSplitViewController

@synthesize masterView;
@synthesize detailView;
@synthesize viewControllers = _viewControllers;
@synthesize botonHideShowDetail = _botonHideShowDetail;
@synthesize oneFingerOneTap = _oneFingerOneTap;
//@synthesize botonHideShowMaster = _botonHideShowMaster;


+ (CustomSplitViewController *) getInstance {
    if (controller == nil) {
        controller = [[CustomSplitViewController alloc] initWithNibName:@"CustomSplitViewController" bundle:nil];
    }
    return controller;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    controller = self;
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.edgesForExtendedLayout = UIRectEdgeNone;

    self.view.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor redColor];
    
    self.masterView = [[UIView alloc] init];
    self.detailView = [[UIView alloc] init];
    
    UINavigationController * masterViewController = [self.viewControllers objectAtIndex:0];
    //masterViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UINavigationController * detailViewController = [self.viewControllers objectAtIndex:1];
    //detailViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    [self addChildViewController:masterViewController];
    [self addChildViewController:detailViewController];
    
    [self.masterView addSubview:masterViewController.view];
    [self.detailView addSubview:detailViewController.view];
    
    [self setupRecognizers];
    
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:1];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHideReceived:) name:@"hideDrawer" object:nil];
}

-(void) notificationHideReceived: (NSNotification *) notification {
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        [self hideMaster];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



-(void) cargarLandscape {//carga master y detail juntos en landscape
    //self.masterView.transform = CGAffineTransformMakeScale(1,1);
    
    CGRect masterFrame = CGRectMake(0, 20, baseMaster, altoMasterLandscape);
    CGRect detailFrame = CGRectMake(baseMaster + 1, 20, baseDetailLandscape, altoDetailLandscape);
    
    self.masterView.frame = masterFrame;
    self.detailView.frame = detailFrame;
    
    UINavigationController * masterNavigationController = [self.viewControllers objectAtIndex:0];
    masterNavigationController.view.frame = CGRectMake(0, 0, baseMaster, altoMasterLandscape);//navigation controller del master
    
    UINavigationController * detailNavigationController = [self.viewControllers objectAtIndex:1];//navigation controller del detail
    detailNavigationController.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscape);
    
    [self quitarBotonDrawer];
    
    [self.detailView removeGestureRecognizer:self.oneFingerOneTap];
    [self.detailView removeGestureRecognizer:self.oneFngerPan];
    
    [self.view addSubview:self.masterView];
    [self.view addSubview:self.detailView];
    
}

-(void) cargarPortrait {//carga el detail
    CGRect masterFrame = CGRectMake(0, 20, baseMaster, altoMasterPortrait);
    CGRect detailFrame = CGRectMake(0, 20, baseDetailPortrait, altoDetailPortrait);
    
    self.masterView.frame = masterFrame;
    self.detailView.frame = detailFrame;
    
    UINavigationController * masterNavigationController = [self.viewControllers objectAtIndex:0];
    masterNavigationController.view.frame = CGRectMake(0, 0, baseMaster, altoMasterPortrait);
    
    UINavigationController * detailNavigationController = [self.viewControllers objectAtIndex:1];//navigation controller del detail
    detailNavigationController.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortrait);
    
    [self ponerBotonesOpenDrawer];
    
    [self.detailView addGestureRecognizer:self.oneFngerPan];
    
    [self.view addSubview:self.masterView];
    [self.view addSubview:self.detailView];
    
}

-(void) ponerBotonesOpenDrawer {
    self.buttons = [NSMutableArray array];
    UIViewController * mainViewController = [self.viewControllers objectAtIndex:1];
    if ([mainViewController class] == [UINavigationController class]) {//NavigationController
        UINavigationController * navigationController = (UINavigationController *) mainViewController;
        //if (navigationController.viewControllers.count == 1) {
        UIViewController * rootViewController = [navigationController.viewControllers objectAtIndex:0];
        UIButton *aButtonFavorite = [self crearBarButtonBoton:@"drawer.png"];
        [aButtonFavorite addTarget:self action:@selector(showMaster) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithCustomView:aButtonFavorite];
        rootViewController.navigationItem.leftBarButtonItem = button;
        [self.buttons addObject:button];
        //}
    }
}

-(void) ponerBotonesCerrarDrawer {
    self.buttons = [NSMutableArray array];
    UIViewController * mainViewController = [self.viewControllers objectAtIndex:1];
    if ([mainViewController class] == [UINavigationController class]) {//NavigationController
        UINavigationController * navigationController = (UINavigationController *) mainViewController;
        if (navigationController.viewControllers.count == 1) {
            UIViewController * rootViewController = [navigationController.viewControllers objectAtIndex:0];
            
            UIButton *aButtonFavorite = [self crearBarButtonBoton:@"drawer.png"];
            [aButtonFavorite addTarget:self action:@selector(hideMaster) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithCustomView:aButtonFavorite];
            rootViewController.navigationItem.leftBarButtonItem = button;
            [self.buttons addObject:button];
        }
        
    }
}

-(void) quitarBotonDrawer {
    UIViewController * mainViewController = [self.viewControllers objectAtIndex:1];
    if ([mainViewController class] == [UINavigationController class]) {//NavigationController
        UINavigationController * navigationController = (UINavigationController *) mainViewController;
        if (navigationController.viewControllers.count == 1) {
            UIViewController * rootViewController = [navigationController.viewControllers objectAtIndex:0];
            rootViewController.navigationItem.leftBarButtonItem = nil;
        }
        
    }
}

-(UIButton *) crearBarButtonBoton: (NSString *) image {
    UIImage *buttonImageFavorite = [UIImage imageNamed:image];
    UIButton *aButtonFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
    aButtonFavorite.bounds = CGRectMake(0.0, 0.0, 32, 32);
    [aButtonFavorite setImage:buttonImageFavorite forState:UIControlStateNormal];
    return aButtonFavorite;
}

-(void) showMaster {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:nil];
    NSArray * botones = [NSArray arrayWithArray:self.buttons];
    for (UIBarButtonItem * button in botones) {
        [self ponerBotonesCerrarDrawer];
    }
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        [self.detailView addGestureRecognizer:self.oneFingerOneTap];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect frame = self.detailView.frame;
            frame.origin.x = baseMaster + 1;
            self.detailView.frame = frame;
        } completion:^(BOOL finished){
            
        }];
    }
    
    
}

-(void) hideMaster {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hide" object:nil];
    NSArray * botones = [NSArray arrayWithArray:self.buttons];
    for (UIBarButtonItem * button in botones) {
        [self ponerBotonesOpenDrawer];
    }
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        [self.detailView removeGestureRecognizer:self.oneFingerOneTap];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect frame = self.detailView.frame;
            frame.origin.x = 0;
            self.detailView.frame = frame;
        } completion:^(BOOL finished){
            
        }];
    }
    
    
}


/*******************************************************************************
 Gestion de la rotacion
 ******************************************************************************/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self cargarLandscape];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RotateToLandscape" object:nil];
    }
    // Si esta en portrait
    else if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self cargarPortrait];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RotateToPortrait" object:nil];
    }
}

/*******************************************************************************
 Gestion de Gestos
 ******************************************************************************/

-(void) setupRecognizers {
    self.oneFingerOneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerOneTap:)];
    // Set required taps and number of touches
    [self.oneFingerOneTap setNumberOfTapsRequired:1];
    [self.oneFingerOneTap setNumberOfTouchesRequired:1];
    
    self.oneFngerPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMoveAround:)];
    [self.oneFngerPan setMaximumNumberOfTouches:1];
    [self.oneFngerPan setMinimumNumberOfTouches:1];
    [self.oneFngerPan setDelegate:self];
    
}

- (IBAction) oneFingerOneTap: (id) sender {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self hideMaster];
    }
}

-(void)panGestureMoveAround:(UIPanGestureRecognizer *)panGesture {
    
    CGPoint translation = [panGesture translationInView:self.view];
    
    if (translation.x > 0) {//Hacia la derecha
        if (panGesture.view.frame.origin.x < baseMaster + 1) {
            CGRect frame = panGesture.view.frame;
            if ((frame.origin.x + translation.x) > baseMaster + 1) {
                frame.origin.x = baseMaster + 1;
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
            [self showMaster];
        } else {
            [self hideMaster];
        }
        panApplied = 0;
    }
}



@end
