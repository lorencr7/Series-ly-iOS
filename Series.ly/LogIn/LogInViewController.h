//
//  LogInViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController  <UITextFieldDelegate> {
    CGFloat texFieldWidth;
    UITextField *textFieldActual;
    UIActivityIndicatorView *activityIndicator;
    
    BOOL keyboardShown;
}

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView * elementsView;
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelLogo;

@property (strong, nonatomic) UITextField *userTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *logginButton;

@end

@interface LogInViewControllerIpad : LogInViewController

@end

@interface LogInViewControllerIphone : LogInViewController

@end