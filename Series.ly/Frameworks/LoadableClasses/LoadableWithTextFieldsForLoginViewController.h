//
//  LoadableWithTextFieldsForLoginViewController.h
//  hooola
//
//  Created by Lorenzo Villarroel Pérez on 23/07/13.
//  Copyright (c) 2013 jobssy. All rights reserved.
//

#import "LoadableViewController.h"

@class HTAutocompleteTextField,InputBox;
@interface LoadableWithTextFieldsForLoginViewController : LoadableViewController //<UITextFieldDelegate>

@property(strong, nonatomic) NSMutableArray * firstResponders;

@property(assign, nonatomic) CGFloat texFieldWidth;
@property(strong, nonatomic) UITextField * textFieldActual;

-(void) inputBoxTapped: (InputBox *) inputBox;

@end
