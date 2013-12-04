//
//  LoginiPhoneViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoginiPhoneViewController.h"
#import "HTAutocompleteTextField.h"
#import "HTAutocompleteManager.h"

@interface LoginiPhoneViewController ()

@end

@implementation LoginiPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createEmailTextfield {
    [super createEmailTextfield];
    [self configureTextFieldAppareanceWith:(UITextField *)self.emailTextField placeholder:NSLocalizedString(@"UserTextFieldPlaceHolder", nil) originY:280 returnKey:UIReturnKeyGo];
    
}

-(void) createPasswordTextField {
    [super createPasswordTextField];
    [self configureTextFieldAppareanceWith:self.passwordTextField placeholder:NSLocalizedString(@"PasswordTextFieldPlaceHolder", nil) originY:self.emailTextField.frame.origin.y + self.emailTextField.frame.size.height + 10 returnKey:UIReturnKeyGo];
}

-(void) createLoginButton {
    [super createLoginButton];
    int buttonWidth = 160;
    self.loginButton.frame = CGRectMake(self.view.frame.size.width/2 - buttonWidth/2,
                                        self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 10,
                                        buttonWidth,
                                        40);
}

@end
