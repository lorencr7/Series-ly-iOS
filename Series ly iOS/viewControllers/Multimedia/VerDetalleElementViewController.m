//
//  VerDetalleElementViewController.m
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 31/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "VerDetalleElementViewController.h"
#import "MediaElement.h"
#import "DetalleElementViewController.h"

@interface VerDetalleElementViewController ()

@end

@implementation VerDetalleElementViewController

- (id)initWithMediaElement: (MediaElement *) mediaElement {
    self = [super init];
    if (self) {
        self.mediaElement = mediaElement;
        self.title = mediaElement.name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.detalleElementViewController = [[DetalleElementViewController alloc] initWithFrame:self.view.frame MediaElement:self.mediaElement];
    //self.navigationItem.rightBarButtonItems = self.detalleElementViewController.navigationItem.rightBarButtonItems;
    [self addChildViewController:self.detalleElementViewController];
    [self.view addSubview:self.detalleElementViewController.view];
    
    
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
