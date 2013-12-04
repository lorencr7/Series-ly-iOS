//
//  LoginViewController.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoadableWithTextFieldsForLoginViewController.h"

@class HTAutocompleteTextField;
@interface LoginViewController : LoadableWithTextFieldsForLoginViewController

@property(strong, nonatomic) HTAutocompleteTextField * emailTextField;
@property(strong, nonatomic) UITextField *passwordTextField;
@property(strong, nonatomic) UIButton * loginButton;

-(void) configureTextFieldAppareanceWith:(UITextField *) textfield  placeholder:(NSString *) placeholder  originY:(CGFloat) originY returnKey:(int) returnKey;

-(void) createEmailTextfield;
-(void) createPasswordTextField;
-(void) createLoginButton;

@end
