//
//  LoginViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoginViewController.h"
#import "HTAutocompleteTextField.h"
#import "HTAutocompleteManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.texFieldWidth = MIN(frame.size.width*0.75, 600);
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

-(BOOL) getData {
    return YES;
}

-(void) createData {
    [self loadScroll];
    [self createEmailTextfield];
    [self createPasswordTextField];
    [self createLoginButton];
    [self stopActivityIndicator];
}

-(void) createEmailTextfield {
    self.emailTextField = [[HTAutocompleteTextField alloc] init];
    //[self configureTextFieldAppareanceWith:self.emailTextField placeholder:NSLocalizedString(@"UserTextFieldPlaceHolder", nil) originY:self.labelTitle.frame.origin.y + self.labelTitle.frame.size.height returnKey:UIReturnKeyGo];
    
    [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
    [self.emailTextField setAutocompleteType:HTAutocompleteTypeEmail];
    [self.firstResponders addObject:self.emailTextField];
    
    [self.scrollView addSubview:self.emailTextField];
}

-(void) createPasswordTextField {
    self.passwordTextField = [[UITextField alloc] init];
    //[self configureTextFieldAppareanceWith:self.passwordTextField placeholder:NSLocalizedString(@"PasswordTextFieldPlaceHolder", nil) originY:self.emailTextField.frame.origin.y + self.emailTextField.frame.size.height + 10 returnKey:UIReturnKeyGo];
    self.passwordTextField.secureTextEntry = YES;
    [self.firstResponders addObject:self.passwordTextField];
    [self.scrollView addSubview:self.passwordTextField];
}

-(void) createLoginButton {
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton setTitle:NSLocalizedString(@"LoginButtonTitle", nil) forState:UIControlStateNormal];
    //int buttonWidth = 160;
    /*self.loginButton.frame = CGRectMake(self.elementsView.frame.size.width/2 - buttonWidth/2,
                                        self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 15,
                                        buttonWidth,
                                        40);*/
    [self.loginButton addTarget:self action:@selector(handlerLogin) forControlEvents:UIControlEventTouchUpInside];
    //[self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    
    [self.scrollView addSubview:self.loginButton];
}

-(void) configureTextFieldAppareanceWith:(UITextField *) textfield  placeholder:(NSString *) placeholder  originY:(CGFloat) originY returnKey:(int) returnKey {
    textfield.frame = CGRectMake(self.view.frame.size.width/2 - self.texFieldWidth/2,
                                 originY,
                                 self.texFieldWidth,
                                 30);
    //textfield.delegate = self;
    textfield.backgroundColor = [UIColor whiteColor];
    
    // Texto que aparece antes de que se haya escrito nada
    textfield.placeholder = placeholder;
    
    // Ponemos un pequeño margen izquierdo
    textfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    
    // Tipo y tamaño de fuente y mayusculas
    textfield.font = [UIFont systemFontOfSize:23];
    textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    // Apariencia
    textfield.borderStyle = UITextBorderStyleLine;
    textfield.backgroundColor = [UIColor whiteColor];
    
    // Autocorreccion y tecla intro
    textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    [textfield setReturnKeyType:returnKey];
    
    // Bordes
    textfield.clipsToBounds = YES;
    
    // Añadimos la barra al teclado
    textfield.inputAccessoryView = [self loadBar];
}

-(UIToolbar *) loadBar {
    // Propiedades del ToolBar
    UIToolbar *bar = [[UIToolbar alloc] init];
    bar.frame = CGRectMake(0, 0.0, self.view.frame.size.width, 45);
    [bar setBarStyle:UIBarStyleBlackTranslucent];
    
    // Botones
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"LoadBarPreviousButtonTitle", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(prevTextField)];
    UIBarButtonItem *nextButton =[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"LoadBarNextButtonTitle", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(nextTextField)];
    
    // Este Boton es un espacio en blanco
    UIBarButtonItem *spaceButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"LoadBarDoneButtonTitle", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(doneEditing)];
    
    // Añadimos los botones al Toolbar
    NSArray *itemsArray = [NSArray arrayWithObjects:backButton, nextButton, spaceButton, doneButton, nil];
    [bar setItems:itemsArray];
    
    return bar;
}

-(void) handlerLogin {
    
}

/**
 @Method nextTextField
 @Description nos desplazamos al textField posterior al actual (si existe)
 @Return void
 **/
-(void) nextTextField {
    int i = 0;
    for (UITextField * textField in self.firstResponders) {
        if ([textField isFirstResponder]) {
            //[textField resignFirstResponder];
            break;
        }
        i++;
    }
    if (i + 1 < self.firstResponders.count) {
        UITextField * newResponder = self.firstResponders[i+1];
        [newResponder becomeFirstResponder];
    }
}

/**
 @Method prevTextField
 @Description nos desplazamos al textField anterior al actual (si existe)
 @Return void
 **/
-(void) prevTextField {
    int i = 0;
    for (UITextField * textField in self.firstResponders) {
        if ([textField isFirstResponder]) {
            //[textField resignFirstResponder];
            break;
        }
        i++;
    }
    if (i > 0) {
        UITextField * newResponder = self.firstResponders[i-1];
        [newResponder becomeFirstResponder];
    }
}

/**
 @Method doneEditing
 @Description encargado de ocultar el teclado cuando hemos terminado de escribir
 @Return void
 **/
-(void) doneEditing {
    for (UITextField * textField in self.firstResponders) {
        if ([textField isFirstResponder]) {
            [textField resignFirstResponder];
            break;
        }
    }
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
        int desplazamiento = keyboardHeight - 40;
        
        CGRect frame = self.scrollView.frame;
        frame.origin.y = frame.origin.y - desplazamiento;
        double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        int curve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
        
        [UIView animateWithDuration:duration delay:0 options:curve animations:^{
            self.scrollView.frame = frame;
        } completion:^(BOOL finished){

        }];
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
    } completion:^(BOOL finished){
        
    }];
}

@end
