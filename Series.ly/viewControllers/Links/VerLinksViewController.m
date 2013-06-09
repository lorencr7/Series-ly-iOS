//
//  ListadoLinksViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "VerLinksViewController.h"
#import "ScreenSizeManager.h"
#import "ListadoLinksViewController.h"

@interface VerLinksViewController ()

@end

@implementation VerLinksViewController

- (id)initWithMediaElement: (MediaElement *) mediaElement {
    self = [super init];
    if (self) {
        self.mediaElement = mediaElement;
        //self.title = @"Enlaces";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.listadoLinksViewController = [[ListadoLinksViewController alloc] initWithFrame:self.view.frame MediaElement:self.mediaElement NavigationItem:self.navigationItem];
    [self addChildViewController:self.listadoLinksViewController];
    [self.view addSubview:self.listadoLinksViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) stopTasks {
    [self.listadoLinksViewController cancelThreadsAndRequests];
}

@end
