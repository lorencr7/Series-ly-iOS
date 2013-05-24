//
//  VerDetalleElementViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "VerDetalleElementViewController.h"
#import "MediaElementUser.h"
#import "ScreenSizeManager.h"
#import "DetalleElementViewController.h"

@interface VerDetalleElementViewController ()

@end

@implementation VerDetalleElementViewController

- (id)initWithMediaElementUser: (MediaElementUser *) mediaElementUser {
    self = [super init];
    if (self) {
        self.mediaElementUser = mediaElementUser;
        self.title = mediaElementUser.name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.detalleElementViewController = [[DetalleElementViewController alloc] initWithFrame:self.view.frame MediaElementUser:self.mediaElementUser];
    [self addChildViewController:self.detalleElementViewController];
    [self.view addSubview:self.detalleElementViewController.view];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) stopTasks {
    [self.detalleElementViewController cancelThreadsAndRequests];
}

@end
