//
//  LoginViewController.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoadableViewController.h"
#import "LoginInputViewController.h"

@class LoginLogoViewController;
@interface LoginViewController : LoadableViewController <LoginInputDelegate>

@property(assign, nonatomic) BOOL keyboardShown;

@property(strong, nonatomic) UIScrollView * scrollView;

@property(strong, nonatomic) LoginInputViewController * loginInputViewController;
@property(strong, nonatomic) LoginLogoViewController * loginLogoViewController;
/*@property(strong, nonatomic) HTAutocompleteTextField * emailTextField;
@property(strong, nonatomic) UITextField *passwordTextField;
@property(strong, nonatomic) UIButton * loginButton;

-(void) configureTextFieldAppareanceWith:(UITextField *) textfield  placeholder:(NSString *) placeholder  originY:(CGFloat) originY returnKey:(int) returnKey;

-(void) createEmailTextfield;
-(void) createPasswordTextField;
-(void) createLoginButton;*/

-(void) createLoginInput;

@end
