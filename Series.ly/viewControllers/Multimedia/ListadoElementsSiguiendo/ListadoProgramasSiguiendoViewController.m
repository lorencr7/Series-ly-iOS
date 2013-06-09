//
//  ListadoProgramasSiguiendoViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 22/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ListadoProgramasSiguiendoViewController.h"
#import "ManejadorServicioWebSeriesly.h"
#import "User.h"
#import "UserCredentials.h"
#import "ASIHTTPRequest.h"

@interface ListadoProgramasSiguiendoViewController ()

@end

@implementation ListadoProgramasSiguiendoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *) getSourceData {
    ManejadorServicioWebSeriesly * manejadorServicioWebSeriesly = [ManejadorServicioWebSeriesly getInstance];
    
    User * usuario = [User getInstance];
    UserCredentials * userCredentials = [UserCredentials getInstance];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:nil];
    [self.requests addObject:request];
    
    usuario.tvShowsFollowing = [manejadorServicioWebSeriesly getUserFollowingTvShowsWithRequest:request ProgressView:nil AuthToken:userCredentials.authToken UserToken:userCredentials.userToken];
    //self.sourceData = usuario.seriesFollowing;
    [self.requests removeObject:request];
    
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    return usuario.tvShowsFollowing;
}

@end
