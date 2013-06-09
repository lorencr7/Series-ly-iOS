//
//  LoadableViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ParentViewController.h"

@interface LoadableViewController : ParentViewController {
    UIActivityIndicatorView *activityIndicator;
}

@property(strong, nonatomic) NSMutableArray * requests;
@property(strong, nonatomic) NSMutableArray * threads;

@property(strong, nonatomic) NSString * mensajeSinConexion;
@property(strong, nonatomic) NSString * mensajeErrorDescarga;
@property(strong, nonatomic) NSString * mensajeDatosVacios;

-(void) iniciarActivityIndicator;
-(void) activateActivityIndicator;
-(void) stopActivityIndicator;

-(void) configureImageView: (NSMutableDictionary *) arguments;

-(void) loadData;
-(BOOL) getData;

-(void) cancelThreadsAndRequests;
-(void) createErrorMessage;

@end
