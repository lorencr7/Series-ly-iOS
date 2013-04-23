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
    self.view.backgroundColor = [UIColor colorWithRed:(197/255.0) green:(197/255.0) blue:(197/255.0) alpha:1];
    //[self willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:0];
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:1];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [self setMasterView:nil];
    [self setDetailView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


/*******************************************************************************
 Carga de elementos
 ******************************************************************************/

-(void) cargarLandscape {//carga master y detail juntos en landscape
    UINavigationController * navigationController;
    UIViewController * viewController;
    
    self.masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, baseMaster, altoMasterLandscape+2)];
    self.detailView = [[UIView alloc] initWithFrame:CGRectMake(baseMaster + 1, 0, baseDetailLandscape, altoDetailLandscape)];
    
    navigationController = [self.viewControllers objectAtIndex:0];
    navigationController.view.frame = CGRectMake(0, 0, baseMaster, altoMasterLandscape+2);//navigation controller del master
    //viewController = [navigationController.viewControllers objectAtIndex:0];
    viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
    viewController.navigationItem.leftBarButtonItem = nil;
    [self.masterView addSubview:navigationController.view];
    
    navigationController = [self.viewControllers objectAtIndex:1];//navigation controller del detail
    navigationController.view.frame = CGRectMake(0, 0, baseDetailLandscape, altoDetailLandscape);
    //viewController = [navigationController.viewControllers objectAtIndex:0];
    viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
    if ([viewController.navigationItem.leftBarButtonItems count] == 0 && [navigationController.viewControllers count] == 1) {
        [self anadirHideButton:viewController];
    } else if ([viewController.navigationItem.leftBarButtonItems count] > 0 && [viewController.navigationItem.leftBarButtonItem.title isEqualToString: @"mostrar"]) {
        [self anadirHideButton:viewController];
    } else
        //////NSLog(@"se carga landscape");
        //[self anadirTapGesture:viewController.view];
        [viewController.view removeGestureRecognizer:self.oneFingerOneTap];
    [viewController.view removeGestureRecognizer:self.swipeLeft];
    [viewController.view removeGestureRecognizer:self.swipeRight];
    //[self anadirHideButton:viewController];
    [self.detailView addSubview:navigationController.view];
    
    //if ([viewController.navigationItem.leftBarButtonItems count] > 0 && [viewController.navigationItem.leftBarButtonItem.title isEqualToString: @"mostrar"]) {
    
    //}
    [self.view addSubview:self.masterView];
    [self.view addSubview:self.detailView];
}

-(void) cargarPortrait {//carga el detail
    UINavigationController * navigationController;
    UIViewController * viewController;
    ////NSLog(@"cargarPortrait");
    self.masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, baseMaster, altoMasterPortrait+2)];
    self.detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, baseDetailPortrait, altoDetailPortrait)];
    
    navigationController = [self.viewControllers objectAtIndex:0];
    navigationController.view.frame = CGRectMake(0, 0, baseMaster, altoMasterPortrait+2);
    //viewController = [navigationController.viewControllers objectAtIndex:0];//navigation controller del master
    viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
    [self.masterView addSubview:navigationController.view];
    
    navigationController = [self.viewControllers objectAtIndex:1];//navigation controller del detail
    navigationController.view.frame = CGRectMake(0, 0, baseDetailPortrait, altoDetailPortrait);
    //viewController = [navigationController.viewControllers objectAtIndex:0];
    viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
    
    // Gestion boton show/hide
    if ([viewController.navigationItem.leftBarButtonItems count] == 0 && [navigationController.viewControllers count] == 1) {
        [self anadirShowButton:viewController];
    } else if ([viewController.navigationItem.leftBarButtonItems count] > 0 && [viewController.navigationItem.leftBarButtonItem.title isEqualToString: @"ocultar"]) {
        [self anadirShowButton:viewController];
    }
    [self anadirSwipeGesture:viewController.view];
    
    [self.detailView addSubview:navigationController.view];
    
    [self.view addSubview:self.masterView];
    [self.view addSubview:self.detailView];
    
    self.masterView.transform = CGAffineTransformMakeScale(0.95,0.98);
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
 Mostrar y ocultar el Master
 ******************************************************************************/

-(void) hideMaster {
    UINavigationController * navigationController;
    UIViewController * viewController;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideMasterLandscape" object:nil];
        // Navigation controller del detail
        navigationController = [self.viewControllers objectAtIndex:1];//navigation controller del detail
        viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
        
        // Cambiamos el buton
        if ([viewController.navigationItem.leftBarButtonItems count] > 0 && [viewController.navigationItem.leftBarButtonItem.title isEqualToString: @"ocultar"]) {
            [self anadirShowButton:viewController];
        }
        
        // Desplazamos elementos (ocultar master)
        [self moveDetailWithX:0 y:0 width:baseLandscape height:altoDetailLandscape scaleX:0.95 scaleY:0.98];
    } else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideMasterPortrait" object:nil];
        // Navigation controller del detail
        navigationController = [self.viewControllers objectAtIndex:1];
        viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
        
        // Cambiamos el buton y le quitamos el gesture reconizer
        if ([viewController.navigationItem.leftBarButtonItems count] > 0 && [viewController.navigationItem.leftBarButtonItem.title isEqualToString: @"ocultar"]) {
            [self anadirShowButton:viewController];
        }
        [viewController.view removeGestureRecognizer:self.oneFingerOneTap];
        
        // Desplazamos elementos (ocultar master)
        //[self moveImage:self.detailView x:0 y:0];
        [self moveDetailWithX:0 y:0 width:self.detailView.frame.size.width height:self.detailView.frame.size.height scaleX:0.95 scaleY:0.98];
    }
}


-(void) showMaster {
    UINavigationController * navigationController;
    UIViewController * viewController;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showMasterLandscape" object:nil];
        // Navigation controller del detail
        navigationController = [self.viewControllers objectAtIndex:1];
        viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
        
        // Cambiamos el buton
        if ([viewController.navigationItem.leftBarButtonItems count] > 0 && [viewController.navigationItem.leftBarButtonItem.title isEqualToString: @"mostrar"]) {
            [self anadirHideButton:viewController];
        }
        
        // Desplazamos elementos
        [self moveDetailWithX:baseMaster + 1 y:0 width:baseDetailLandscape height:altoDetailLandscape scaleX:1 scaleY:1];
    } else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showMasterPortrait" object:nil];
        for (UIView * view in self.masterView.subviews) {
            [view removeFromSuperview];
        }
        // Navigation controller del detail
        navigationController = [self.viewControllers objectAtIndex:1];
        viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
        [self anadirTapGesture:viewController.view];
        
        
        // Cambiamos el buton
        if ([viewController.navigationItem.leftBarButtonItems count] > 0 && [viewController.navigationItem.leftBarButtonItem.title isEqualToString: @"mostrar"]) {
            [self anadirHideButton:viewController];
        }
        
        // Navigation controller del master
        navigationController = [self.viewControllers objectAtIndex:0];
        viewController = [navigationController.viewControllers objectAtIndex:[navigationController.viewControllers count]-1];
        [self.masterView addSubview:navigationController.view];
        
        // Barra separadora
        UIView * barraSeparadora = [[UIView alloc] initWithFrame:CGRectMake(0,0,1,altoPortrait)];
        barraSeparadora.backgroundColor =  [UIColor colorWithRed:(197/255.0) green:(197/255.0) blue:(197/255.0) alpha:1];
        
        // Desplazamos elementos
        [self moveImage:barraSeparadora x:baseMaster y:0];
        //[self moveImage:self.detailView x:321 y:0];
        [self moveDetailWithX:baseMaster + 1 y:0 width:self.detailView.frame.size.width height:self.detailView.frame.size.height scaleX:1 scaleY:1];
    }
}




-(void) anadirHideButton: (UIViewController *) viewController {
    self.botonHideShowDetail = [[UIBarButtonItem alloc] initWithTitle:@"ocultar"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(hideMaster)];
    
    viewController.navigationItem.leftBarButtonItem = self.botonHideShowDetail;
}

-(void) anadirShowButton: (UIViewController *) viewController {
    self.botonHideShowDetail = [[UIBarButtonItem alloc] initWithTitle:@"mostrar"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(showMaster)];
    
    viewController.navigationItem.leftBarButtonItem = self.botonHideShowDetail;
}


/*******************************************************************************
 Gestion de Gestos
 ******************************************************************************/

-(void) anadirTapGesture: (UIView *) view {
    if (!self.oneFingerOneTap) {
        self.oneFingerOneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerOneTap:)];
        // Set required taps and number of touches
        [self.oneFingerOneTap setNumberOfTapsRequired:1];
        [self.oneFingerOneTap setNumberOfTouchesRequired:1];
    }
    // Add the gesture to the view
    [view addGestureRecognizer:self.oneFingerOneTap];
}

-(void) anadirSwipeGesture: (UIView *) view {
    if (!self.swipeLeft) {
        self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        // Set direction
        [self.swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    if (!self.swipeRight) {
        self.swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        // Set direction
        [self.swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    // Add the gesture to the view
    [view addGestureRecognizer:self.swipeLeft];
    [view addGestureRecognizer:self.swipeRight];
}

- (IBAction) oneFingerOneTap: (id) sender {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self hideMaster];
    }
}

- (IBAction)handleSwipeLeft:(UISwipeGestureRecognizer *)sender {
    [self hideMaster];
}


- (IBAction)handleSwipeRight:(UISwipeGestureRecognizer *)sender {
    [self showMaster];
}



/*******************************************************************************
 Movimiento de elementos
 ******************************************************************************/

- (void)moveDetailWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width
                 height:(CGFloat) height scaleX:(CGFloat) scaleX scaleY:(CGFloat)scaleY {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.masterView.transform = CGAffineTransformMakeScale(scaleX,scaleY);
    CGRect frame = CGRectMake(x, y, width, height);
    self.detailView.frame = frame;
    
    // Commit the changes
    [UIView commitAnimations];
}


- (void)moveImage:(UIView *)element x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect frame = CGRectMake(x, y, element.frame.size.width, element.frame.size.height);
    element.frame = frame;
    
    // Commit the changes
    [UIView commitAnimations];
}



@end
