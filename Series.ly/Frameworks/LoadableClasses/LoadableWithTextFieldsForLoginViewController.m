//
//  LoadableWithTextFieldsForLoginViewController.m
//  hooola
//
//  Created by Lorenzo Villarroel Pérez on 23/07/13.
//  Copyright (c) 2013 jobssy. All rights reserved.
//

#import "LoadableWithTextFieldsForLoginViewController.h"

@interface LoadableWithTextFieldsForLoginViewController ()

@end

@implementation LoadableWithTextFieldsForLoginViewController


- (void)viewDidLoad {
    self.firstResponders = [NSMutableArray array];
    [super viewDidLoad];
    
}

-(void) viewWillAppear:(BOOL)animated {
    /*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];*/
}

-(void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*- (void)keyboardWillShow:(NSNotification*)notification {
    
}

- (void)keyboardWillHide:(NSNotification*)notification {

}

- (void)keyboardDidShow:(NSNotification*)notification {

}*/

-(void) inputBoxTapped: (InputBox *) inputBox {
    
}


@end
