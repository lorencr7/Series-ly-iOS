//
//  MultimediaViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MultimediaViewController.h"

static MultimediaViewController * instance;

@interface MultimediaViewController ()

@end

@implementation MultimediaViewController

+(MultimediaViewController *) getInstance {
    if (instance == nil) {
        instance = [[MultimediaViewController alloc] init];
    }
    
    return instance;
}

- (id)initWithTitle: (NSString *) title TipoSourceData: (TipoSourceDataSiguiendo) tipoSourceData {
    self = [super init];
    if (self) {
        self.title = title;
        self.tipoSourceData = tipoSourceData;
    }
    return self;
}

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

@end
