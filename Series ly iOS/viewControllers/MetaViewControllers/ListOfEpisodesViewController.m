//
//  ListOfEpisodesViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ListOfEpisodesViewController.h"

@interface ListOfEpisodesViewController ()

@end

@implementation ListOfEpisodesViewController


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

-(BOOL) hayNuevaInfo {
    if (self.lastSourceData) {
        if (![self.lastSourceData isEqualToArray:self.sourceData]) {
            return YES;
        }
    } else {
        return YES;
    }
    return NO;
}

@end
