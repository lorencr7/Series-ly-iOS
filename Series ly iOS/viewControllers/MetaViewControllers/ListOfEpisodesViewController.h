//
//  ListOfEpisodesViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "RefreshableViewController.h"

@interface ListOfEpisodesViewController : RefreshableViewController

@property (strong, nonatomic) NSMutableArray * lastSourceData;
@property (strong, nonatomic) NSMutableArray * sourceData;


-(BOOL) hayNuevaInfo;

@end
