//
//  LoginViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoginViewController.h"
#import "ManejadorServicioWebSeriesLy.h"
#import "AuthToken.h"
#import "UserToken.h"
#import "UserCredentials.h"
#import "AppDelegate.h"
#import "LoginInputViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.keyboardShown = NO;
        //NSLog(@"%d",self.texFieldWidth);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

-(void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL) getData {
    return YES;
}

-(void) createData {
    [self loadScroll];
    [self createLoginLogo];
    [self createLoginInput];
    [self stopActivityIndicator];
}

-(void) loadScroll {
    CGRect scrollViewFrame = CGRectMake(0,
                                        0,
                                        self.view.frame.size.width,
                                        self.view.frame.size.height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,
                                             self.view.frame.size.height);
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scrollView];
}

-(void) createLoginLogo {
    
}

-(void) createLoginInput {
    
}

-(void) loginPressed:(id)sender {
    [self performSelectorInBackground:@selector(login) withObject:nil];
}

-(void) login {
    [self performSelectorOnMainThread:@selector(activateActivityIndicatorForeGround) withObject:nil waitUntilDone:YES];
    ManejadorServicioWebSeriesLy * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesLy getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    userCredentials.authToken = [manejadorServicioWebSeriesly getAuthTokenWithRequest:nil ProgressView:nil];
    userCredentials.userToken = [manejadorServicioWebSeriesly getUserTokenWithRequest:nil ProgressView:nil  AuthToken:userCredentials.authToken UserName:[self.loginInputViewController getEmailText] Password:[self.loginInputViewController getPasswordText] Remember:@"1"];
    if (userCredentials.userToken.userToken) {
        //UserCredentials * userCredentials = [[UserCredentials alloc] initWithAuthToken:authToken UserToken:userToken];
        
        //userCredentials.authToken = authToken;
        //userCredentials.userToken = userToken;
        NSLog(@"1 %@",userCredentials.authToken);
        NSLog(@"2 %@",userCredentials.userToken);
        AppDelegate * appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        [appDelegate saveData];
        [appDelegate loadContentControllers];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Usuario, Email o contraseña incorrectos" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        NSLog(@"Login incorrecto");
    }
    
    [self performSelectorOnMainThread:@selector(stopActivityIndicatorForeGround) withObject:nil waitUntilDone:YES];
}

/**
 @Method keyboardWillShow
 @Description este metodo se ejecuta cuando el teclado se va a mostrar
 @Param (NSNotification*)notification
 @Return void
 **/
- (void)keyboardWillShow:(NSNotification*)notification {
    if (!self.keyboardShown) { // si no esta mostrado
        self.keyboardShown = YES;
        
        NSDictionary* info = [notification userInfo];
        CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        int keyboardHeight = keyboardSize.height;
        double finalView = self.view.frame.size.height - (self.loginInputViewController.frame.origin.y + self.loginInputViewController.frame.size.height);
        double diferencia = finalView - keyboardHeight - 44;
        if (diferencia < 0) {
            int desplazamiento = keyboardHeight - 100;
            
            CGRect frame = self.scrollView.frame;
            frame.origin.y = frame.origin.y - desplazamiento;
            double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
            int curve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
            
            [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                self.scrollView.frame = frame;
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }
}

/**
 @Method keyboardWillHide
 @Description este metodo se ejecuta cuando el teclado se va a ocultar
 @Param (NSNotification*)notification
 @Return void
 **/
- (void)keyboardWillHide:(NSNotification*)notification {
    self.keyboardShown = NO;
    
    CGRect frame = self.scrollView.frame;
    frame.origin.y = self.view.frame.origin.y;
    
    double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
        self.scrollView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

@end
