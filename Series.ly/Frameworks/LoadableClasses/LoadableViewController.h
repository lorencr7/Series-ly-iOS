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
    UIActivityIndicatorView *activityIndicatorForeGround;
}

@property(assign, nonatomic) CGRect frame;
@property(assign, nonatomic) BOOL firstLoad;

//@property(strong, nonatomic) NSMutableArray * requests;
//@property(strong, nonatomic) NSMutableArray * threads;

@property(strong, nonatomic) NSString * mensajeSinConexion;
@property(strong, nonatomic) NSString * mensajeErrorDescarga;
@property(strong, nonatomic) NSString * mensajeDatosVacios;

@property(strong, nonatomic) NSMutableArray * imagenes;

- (id)initWithFrame: (CGRect) frame;

-(void) iniciarActivityIndicator;
-(void) activateActivityIndicator;
-(void) stopActivityIndicator;

-(void) iniciarActivityIndicatorForeGround;
-(void) activateActivityIndicatorForeGround;
-(void) stopActivityIndicatorForeGround;

-(void) configureImageView: (NSMutableDictionary *) arguments;
-(void) configureImagenes: (NSMutableArray *) imagenes;


-(void) loadData;
-(BOOL) getData;
-(void) createData;

-(void) cancelThreadsAndRequests;
-(void) createErrorMessage;

-(void) clearView;

//-(void) stopTasks;

@end
