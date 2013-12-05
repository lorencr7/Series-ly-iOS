//
//  LoginInputViewController.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 05/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoadableWithTextFieldsForLoginViewController.h"

@protocol LoginInputDelegate <NSObject>
@optional
-(void) loginPressed: (id) sender;
@end

@class HTAutocompleteTextField;
@interface LoginInputViewController : LoadableWithTextFieldsForLoginViewController

@property(weak, nonatomic) id delegate;
@property(strong, nonatomic) HTAutocompleteTextField * emailTextField;
@property(strong, nonatomic) UITextField *passwordTextField;
@property(strong, nonatomic) UIButton * loginButton;

-(NSString *) getEmailText;
-(NSString *) getPasswordText;

@end
