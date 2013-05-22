//
//  LogInViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LogInViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ManejadorServicioWebSeriesly.h"
#import "AuthToken.h"
#import "UserToken.h"
#import "UserCredentials.h"
#import "PerfilViewController.h"
#import "AppDelegate.h"
#import "ManejadorBaseDeDatosBackup.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(56/255.0) green:(115/255.0) blue:(194/255.0) alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    /*if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
     self.view.frame = CGRectMake(0, 0, 1024, 748);
     } else {
     self.view.frame = CGRectMake(0, 0, 768, 1004);
     }*/
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:1];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************************* Manejadores de los botones

/**
 @Method nextTextField
 @Description nos desplazamos al textField posterior al actual (si existe)
 @Return void
 **/
-(void) nextTextField {
    if (textFieldActual == self.userTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
}

/**
 @Method prevTextField
 @Description nos desplazamos al textField anterior al actual (si existe)
 @Return void
 **/
-(void) prevTextField {
    if (textFieldActual == self.passwordTextField) {
        [self.userTextField becomeFirstResponder];
    }
}

/**
 @Method doneEditing
 @Description encargado de ocultar el teclado cuando hemos terminado de escribir
 @Return void
 **/
-(void) doneEditing {
    [textFieldActual resignFirstResponder];
}

/**
 @Method startFeedback
 @Description metodo encargado de iniciar la animacion del activityIndicator
 @Return void
 **/
-(void) startFeedback {
    //[[ActivityIndicatorManager getInstance] activateActivityIndicator];
    [activityIndicator startAnimating];
}

/**
 @Method stopFeedback
 @Description metodo encargado de parar la animacion del activityIndicator
 @Return void
 **/
-(void) stopFeedback {
    //[[ActivityIndicatorManager getInstance] unactivateActivityIndicator];
    [activityIndicator stopAnimating];
}

/**
 @Method handlerLogging
 @Description este metodo es el encargado de realizar la operaciones para el inicio de sesion en el sistema
 @Return void
 **/
-(void) handlerLogging {
    NSThread * threadActivateFeedback = [[NSThread alloc] initWithTarget:self selector:@selector(startFeedback) object:nil];
    NSThread * threadstopFeedback = [[NSThread alloc] initWithTarget:self selector:@selector(stopFeedback) object:nil];
    [threadActivateFeedback start];
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    AuthToken * authToken = [manejadorServicioWebSeriesly getAuthTokenWithRequest:nil ProgressView:nil];
    UserToken * userToken = [manejadorServicioWebSeriesly getUserTokenWithRequest:nil ProgressView:nil  AuthToken:authToken UserName:self.userTextField.text Password:self.passwordTextField.text Remember:@"1"];
    if (userToken.userToken) {
        //UserCredentials * userCredentials = [[UserCredentials alloc] initWithAuthToken:authToken UserToken:userToken];
        UserCredentials * userCredentials = [UserCredentials getInstance];
        userCredentials.authToken = authToken;
        userCredentials.userToken = userToken;
        //[PerfilViewController setUserCredentials:userCredentials];
        [[ManejadorBaseDeDatosBackup getInstance] guardarUserCredentials:userCredentials];
        //[PerfilViewController setUserCredentials: userCredentials];
        AppDelegate * appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        [appDelegate loadContentControllers];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Usuario, Email o contraseña incorrectos" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        NSLog(@"Login incorrecto");
    }
    [threadstopFeedback start];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
}

//************************* Delegate

/**
 @Method textFieldDidBeginEditing
 @Description metod encargado de indicar cuando a empezado la edicion en un textfield
 @Param (UITextField *)textField
 @Return void
 **/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textFieldActual = textField;
}

/**
 @Method textField
 @Description metodo encargado de controlar la accion de pulsar intro
 @Param (UITextField *)textField
 @Param (NSRange)range
 @Param (NSString *)string
 @Return (BOOL)
 **/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        //[textFieldActual resignFirstResponder];
        [self handlerLogging];
        return FALSE;
    }
    return TRUE;
}

@end




@implementation LogInViewControllerIpad

- (id)init {
    self = [super init];
    if (self) {
        
        //NSLog(@"%.2f,%.2f,%.2f",self.view.frame.origin.y,self.view.frame.size.height,self.view.frame.size.width);
    }
    return self;
}

- (void)viewDidLoad {
    
    keyboardShown = NO;
    texFieldWidth = 230;
    
    // Llamamos a los diferentes metodos que se encargan de componer la apariencia de la ventana
    [self loadScroll];
    [self loadElementsView];
    [self loadHeader];
    [self loadUserTextField];
    [self loadPasswordTextField];
    [self loadLoggingButton];
    [self loadActivity];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.view.frame = CGRectMake(0, 0, 1024, 748);
        
    } else {
        self.view.frame = CGRectMake(0, 0, 768, 1004);
    }
    self.scrollView.frame = self.view.frame;
    
    self.scrollView.frame = self.view.frame;
    
    CGRect frame = self.logo.frame;
    frame.origin.x = self.view.frame.size.width*0.05;
    self.logo.frame = frame;
    
    double factor = 1.45;
    frame = self.elementsView.frame;
    frame.origin.x = (self.view.frame.size.width/factor) - (self.labelLogo.frame.size.width/2);
    //frame.origin.y = self.view.frame.size.height*0.28;
    self.elementsView.frame = frame;
    /*frame = self.labelLogo.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (self.labelLogo.frame.size.width/2);
     self.labelLogo.frame = frame;
     
     frame = self.labelTitle.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (texFieldWidth/2);
     self.labelTitle.frame = frame;
     
     frame = self.userTextField.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (texFieldWidth/2);
     self.userTextField.frame = frame;
     
     frame = self.passwordTextField.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (texFieldWidth/2);
     self.passwordTextField.frame = frame;
     
     frame = self.logginButton.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (160/2);
     self.logginButton.frame = frame;*/
}

/**
 @Method loadScroll
 @Description metodo encargado de cargar un scrollView sobre el view principal
 @Return void
 **/
-(void) loadScroll {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    //self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scrollView];
}

-(void) loadElementsView {
    self.elementsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.3, 300, 375)];
    self.elementsView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.scrollView addSubview:self.elementsView];
}

/**
 @Method loadHeader
 @Description metodo encargado de cargar la apariencia de la parte superior de la ventana, antes de los textfield
 @Return void
 **/
-(void) loadHeader {
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoSeriesly375x375.png"]];
    self.logo.frame = CGRectMake(0, self.view.frame.size.height*0.3, self.logo.frame.size.width, self.logo.frame.size.height);
    self.logo.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.scrollView addSubview:self.logo];
    
    //self.labelLogo = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logo.frame.origin.y + 20, 0, 0)];
    self.labelLogo = [[UILabel alloc] initWithFrame:CGRectMake((self.elementsView.frame.size.width/2) - (texFieldWidth/2), 0, 0, 0)];
    self.labelLogo.text = NSLocalizedString(@"LabelLogoText", nil);
    self.labelLogo.textAlignment = NSTextAlignmentCenter;
    self.labelLogo.font = [UIFont boldSystemFontOfSize:40];
    self.labelLogo.textColor = [UIColor whiteColor];
    self.labelLogo.backgroundColor = [UIColor clearColor];
    [self.labelLogo sizeToFit];
    [self.elementsView addSubview:self.labelLogo];
    
    //self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logo.frame.origin.y + 80, texFieldWidth, 40)];
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + 60, texFieldWidth, 40)];
    self.labelTitle.text = NSLocalizedString(@"LabelTitleText", nil);
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.font = [UIFont boldSystemFontOfSize:20];
    //self.labelTitle.textColor = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.backgroundColor = [UIColor clearColor];
    //self.labelTitle.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.elementsView addSubview:self.labelTitle];
}

/**
 @Method loadUserTextField
 @Description metodo encargado de iniciar y cargar la apariencia del textField user
 @Return void
 **/
-(void) loadUserTextField {
    self.userTextField = [[UITextField alloc] init];
    [self configureTextFieldAppareanceWith:self.userTextField placeholder:NSLocalizedString(@"UserTextFieldPlaceHolder", nil) originY:self.labelTitle.frame.origin.y + self.labelTitle.frame.size.height + 0 returnKey:UIReturnKeyGo];
    //self.userTextField.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [self.elementsView addSubview:self.userTextField];
}

/**
 @Method loadPasswordTextField
 @Description metodo encargado de iniciar y cargar la apariencia del textField password
 @Return void
 **/
-(void) loadPasswordTextField {
    self.passwordTextField = [[UITextField alloc] init];
    [self configureTextFieldAppareanceWith:self.passwordTextField placeholder:NSLocalizedString(@"PasswordTextFieldPlaceHolder", nil) originY:self.userTextField.frame.origin.y + self.userTextField.frame.size.height + 10 returnKey:UIReturnKeyGo];
    self.passwordTextField.secureTextEntry = YES;
    [self.elementsView addSubview:self.passwordTextField];
}

/**
 @Method loadLoggingButton
 @Description metodo encargado de iniciar y cargar la apariencia del boton de inicio de sesion
 @Return void
 **/
-(void) loadLoggingButton {
    self.logginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.logginButton setTitle:NSLocalizedString(@"LoggInButtonTitle", nil) forState:UIControlStateNormal];
    self.logginButton.frame = CGRectMake((self.elementsView.frame.size.width/2) - (texFieldWidth/2), self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 15, 160, 40);
    [self.logginButton addTarget:self action:@selector(handlerLogging) forControlEvents:UIControlEventTouchUpInside];
    [self.elementsView addSubview:self.logginButton];
}

/**
 @Method configureTextFieldAppareanceWith
 @Description metodo encargado de establecer la apariencia de los textField basada en unos parametros de referencia
 @Param (UITextField *) textfield
 @Param (NSString *) placeholder
 @Param (CGFloat) originY
 @Param (int) returnKey
 @Return void
 **/
-(void) configureTextFieldAppareanceWith:(UITextField *) textfield  placeholder:(NSString *) placeholder  originY:(CGFloat) originY returnKey:(int) returnKey{
    textfield.frame = CGRectMake(0, originY, texFieldWidth, 30);
    textfield.delegate = self;
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
    textfield.borderStyle = UITextBorderStyleNone;
    textfield.backgroundColor = [UIColor whiteColor];
    
    // Autocorreccion y tecla intro
    textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    [textfield setReturnKeyType:returnKey];
    
    // Bodes
    textfield.clipsToBounds = YES;
    textfield.layer.cornerRadius = 5;
    textfield.layer.borderWidth = 1.5;
    textfield.layer.borderColor = [UIColor grayColor].CGColor;
    
    // Añadimos la barra al teclado
    textfield.inputAccessoryView = [self loadBar];
}

/**
 @Method loadBar
 @Description metodo encargado de preparar el toolbar que se le añadira al teclado justo encima, cuando este visible
 @Return (UIToolbar *)
 **/
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

/**
 @Method loadActivity
 @Description metodo encargado de crear y establecer la apariencia al activityIndicartor
 @Return void
 **/
-(void) loadActivity {
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setCenter:CGPointMake(self.view.frame.size.width/1.5, self.view.frame.size.height/2.0)];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator setFrame:CGRectMake(self.view.frame.size.width/1.5 - 70, self.view.frame.size.height/4.0 - 70, 140, 140)];
    [activityIndicator.layer setBackgroundColor:[[UIColor colorWithWhite:0.0 alpha:0.75] CGColor]];
    [activityIndicator.layer setCornerRadius: 10];
    [self.view addSubview:activityIndicator];
}

/**
 @Method keyboardWillShow
 @Description este metodo se ejecuta cuando el teclado se va a mostrar
 @Param (NSNotification*)notification
 @Return void
 **/
- (void)keyboardWillShow:(NSNotification*)notification {
    if (!keyboardShown) { // si no esta mostrado
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            keyboardShown = YES;
            
            // preparamos una animacion para subir todos los elementos hacia arriba en el mismo tiempo en el que aparece el teclado
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
            [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
            
            CGRect frame = self.scrollView.frame;
            frame.origin.y = frame.origin.y - 100;
            self.scrollView.frame = frame;
            
            [UIView commitAnimations];
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
    keyboardShown = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    
    CGRect frame = self.scrollView.frame;
    frame.origin.y = self.view.frame.origin.y;
    self.scrollView.frame = frame;
    
    [UIView commitAnimations];
}

@end

@implementation LogInViewControllerIphone

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    
    keyboardShown = NO;
    texFieldWidth = 230;
    
    // Llamamos a los diferentes metodos que se encargan de componer la apariencia de la ventana
    [self loadScroll];
    [self loadElementsView];
    [self loadHeader];
    [self loadUserTextField];
    [self loadPasswordTextField];
    [self loadLoggingButton];
    [self loadActivity];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) shouldAutorotate {
    return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    /*if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
     self.view.frame = CGRectMake(0, 0, 1024, 748);
     
     } else {
     self.view.frame = CGRectMake(0, 0, 768, 1004);
     }*/
    self.scrollView.frame = self.view.frame;
    
    
    CGRect frame = self.logo.frame;
    frame.origin.x = (self.view.frame.size.width/2) - (self.logo.frame.size.width/2);
    self.logo.frame = frame;
    
    double factor = 2;
    frame = self.elementsView.frame;
    frame.origin.x = (self.view.frame.size.width/factor) - (self.elementsView.frame.size.width/2);
    //frame.origin.y = self.view.frame.size.height*0.28;
    self.elementsView.frame = frame;
    /*frame = self.labelLogo.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (self.labelLogo.frame.size.width/2);
     self.labelLogo.frame = frame;
     
     frame = self.labelTitle.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (texFieldWidth/2);
     self.labelTitle.frame = frame;
     
     frame = self.userTextField.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (texFieldWidth/2);
     self.userTextField.frame = frame;
     
     frame = self.passwordTextField.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (texFieldWidth/2);
     self.passwordTextField.frame = frame;
     
     frame = self.logginButton.frame;
     frame.origin.x = (self.view.frame.size.width/factor) - (160/2);
     self.logginButton.frame = frame;*/
}

/**
 @Method loadScroll
 @Description metodo encargado de cargar un scrollView sobre el view principal
 @Return void
 **/
-(void) loadScroll {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    //self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scrollView];
}

-(void) loadElementsView {
    self.elementsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.3, texFieldWidth, 375)];
    self.elementsView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.scrollView addSubview:self.elementsView];
}

/**
 @Method loadHeader
 @Description metodo encargado de cargar la apariencia de la parte superior de la ventana, antes de los textfield
 @Return void
 **/
-(void) loadHeader {
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoSeriesly144x144.png"]];
    self.logo.frame = CGRectMake(0, 50, self.logo.frame.size.width, self.logo.frame.size.height);
    self.logo.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.scrollView addSubview:self.logo];
    
    //165 es el tamaño del label despues de un sizetofit
    self.labelLogo = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2) - (165/2), 0, 0, 0)];
    self.labelLogo.text = NSLocalizedString(@"LabelLogoText", nil);
    self.labelLogo.textAlignment = NSTextAlignmentCenter;
    self.labelLogo.font = [UIFont boldSystemFontOfSize:40];
    self.labelLogo.textColor = [UIColor whiteColor];
    self.labelLogo.backgroundColor = [UIColor clearColor];
    [self.labelLogo sizeToFit];
    [self.scrollView addSubview:self.labelLogo];
    
    //self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logo.frame.origin.y + 80, texFieldWidth, 40)];
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + 60, texFieldWidth, 40)];
    self.labelTitle.text = NSLocalizedString(@"LabelTitleText", nil);
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.font = [UIFont boldSystemFontOfSize:20];
    //self.labelTitle.textColor = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.backgroundColor = [UIColor clearColor];
    //self.labelTitle.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.elementsView addSubview:self.labelTitle];
}

/**
 @Method loadUserTextField
 @Description metodo encargado de iniciar y cargar la apariencia del textField user
 @Return void
 **/
-(void) loadUserTextField {
    self.userTextField = [[UITextField alloc] init];
    [self configureTextFieldAppareanceWith:self.userTextField placeholder:NSLocalizedString(@"UserTextFieldPlaceHolder", nil) originY:self.labelTitle.frame.origin.y + self.labelTitle.frame.size.height + 0 returnKey:UIReturnKeyGo];
    //self.userTextField.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [self.elementsView addSubview:self.userTextField];
}

/**
 @Method loadPasswordTextField
 @Description metodo encargado de iniciar y cargar la apariencia del textField password
 @Return void
 **/
-(void) loadPasswordTextField {
    self.passwordTextField = [[UITextField alloc] init];
    [self configureTextFieldAppareanceWith:self.passwordTextField placeholder:NSLocalizedString(@"PasswordTextFieldPlaceHolder", nil) originY:self.userTextField.frame.origin.y + self.userTextField.frame.size.height + 10 returnKey:UIReturnKeyGo];
    self.passwordTextField.secureTextEntry = YES;
    [self.elementsView addSubview:self.passwordTextField];
}

/**
 @Method loadLoggingButton
 @Description metodo encargado de iniciar y cargar la apariencia del boton de inicio de sesion
 @Return void
 **/
-(void) loadLoggingButton {
    self.logginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.logginButton setTitle:NSLocalizedString(@"LoggInButtonTitle", nil) forState:UIControlStateNormal];
    self.logginButton.frame = CGRectMake((self.elementsView.frame.size.width/2) - (160/2), self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 15, 160, 40);
    [self.logginButton addTarget:self action:@selector(handlerLogging) forControlEvents:UIControlEventTouchUpInside];
    [self.elementsView addSubview:self.logginButton];
}

/**
 @Method configureTextFieldAppareanceWith
 @Description metodo encargado de establecer la apariencia de los textField basada en unos parametros de referencia
 @Param (UITextField *) textfield
 @Param (NSString *) placeholder
 @Param (CGFloat) originY
 @Param (int) returnKey
 @Return void
 **/
-(void) configureTextFieldAppareanceWith:(UITextField *) textfield  placeholder:(NSString *) placeholder  originY:(CGFloat) originY returnKey:(int) returnKey{
    textfield.frame = CGRectMake(0, originY, texFieldWidth, 30);
    textfield.delegate = self;
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
    textfield.borderStyle = UITextBorderStyleNone;
    textfield.backgroundColor = [UIColor whiteColor];
    
    // Autocorreccion y tecla intro
    textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    [textfield setReturnKeyType:returnKey];
    
    // Bodes
    textfield.clipsToBounds = YES;
    textfield.layer.cornerRadius = 5;
    textfield.layer.borderWidth = 1.5;
    textfield.layer.borderColor = [UIColor grayColor].CGColor;
    
    // Añadimos la barra al teclado
    textfield.inputAccessoryView = [self loadBar];
}

/**
 @Method loadBar
 @Description metodo encargado de preparar el toolbar que se le añadira al teclado justo encima, cuando este visible
 @Return (UIToolbar *)
 **/
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

/**
 @Method loadActivity
 @Description metodo encargado de crear y establecer la apariencia al activityIndicartor
 @Return void
 **/
-(void) loadActivity {
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setCenter:CGPointMake(self.view.frame.size.width/1.5, self.view.frame.size.height/2.0)];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator setFrame:CGRectMake(self.view.frame.size.width/2.0 - 70, self.view.frame.size.height/4.0 - 70, 140, 140)];
    [activityIndicator.layer setBackgroundColor:[[UIColor colorWithWhite:0.0 alpha:0.75] CGColor]];
    [activityIndicator.layer setCornerRadius: 10];
    [self.view addSubview:activityIndicator];
}

/**
 @Method keyboardWillShow
 @Description este metodo se ejecuta cuando el teclado se va a mostrar
 @Param (NSNotification*)notification
 @Return void
 **/
- (void)keyboardWillShow:(NSNotification*)notification {
    if (!keyboardShown) { // si no esta mostrado
        keyboardShown = YES;
        
        // preparamos una animacion para subir todos los elementos hacia arriba en el mismo tiempo en el que aparece el teclado
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
        [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
        
        CGRect frame = self.scrollView.frame;
        frame.origin.y = frame.origin.y - 200;
        self.scrollView.frame = frame;
        
        [UIView commitAnimations];
    }
}

/**
 @Method keyboardWillHide
 @Description este metodo se ejecuta cuando el teclado se va a ocultar
 @Param (NSNotification*)notification
 @Return void
 **/
- (void)keyboardWillHide:(NSNotification*)notification {
    keyboardShown = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    
    CGRect frame = self.scrollView.frame;
    frame.origin.y = self.view.frame.origin.y;
    self.scrollView.frame = frame;
    
    [UIView commitAnimations];
}

@end
