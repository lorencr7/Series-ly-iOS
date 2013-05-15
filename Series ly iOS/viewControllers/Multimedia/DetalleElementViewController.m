//
//  DetalleElementViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DetalleElementViewController.h"
#import "FullInfo.h"
#import "ManejadorServicioWebSeriesly.h"
#import "UserCredentials.h"
#import "MediaElementUser.h"

@interface DetalleElementViewController ()

@end

@implementation DetalleElementViewController

- (id)initWithFrame: (CGRect) frame MediaElementUser: (MediaElementUser *) mediaElementUser {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.mediaElementUser = mediaElementUser;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadFullInfoFromMediaElementUser:) object:self.mediaElementUser];
    [thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) downloadFullInfoFromMediaElementUser: (MediaElementUser *) mediaElementUser {
    ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
    
    UserCredentials * userCredentials = [UserCredentials getInstance];
    self.fullInfo = [manejadorServicioWeb getMediaFullInfoWithRequest:nil
                                                         ProgressView:nil
                                                            AuthToken:userCredentials.authToken
                                                            UserToken:userCredentials.userToken
                                                                  Idm:self.mediaElementUser.idm
                                                            MediaType:self.mediaElementUser.mediaType];
    
    
    
    [self createDetalleFromFullInfo:self.fullInfo];
    [self stopActivityIndicator];
}

-(void) createDetalleFromFullInfo: (FullInfo *) fullInfo {
    UILabel * plotLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    plotLabel.backgroundColor = [UIColor clearColor];
    plotLabel.text = fullInfo.plot;
    plotLabel.numberOfLines = 4;
    plotLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [plotLabel sizeToFit];
    [self.view addSubview:plotLabel];
    
    
    //UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1)];
    //view.backgroundColor = [UIColor redColor];
    //[self.view addSubview:view];
}

@end
