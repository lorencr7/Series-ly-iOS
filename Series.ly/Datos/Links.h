//
//  Links.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 24/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Serializable.h"

@interface Links : Serializable

@property(strong,nonatomic) NSMutableArray * officialServer;
@property(strong,nonatomic) NSMutableArray * streaming;
@property(strong,nonatomic) NSMutableArray * directDownload;
@property(assign,nonatomic) int error;

@end
