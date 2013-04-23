//
//  Pending.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Serializable.h"
@interface Pending : Serializable

@property (strong, nonatomic) NSString * season;
@property (strong, nonatomic) NSString * episode;
@property (strong, nonatomic) NSString * full;

- (id)initWithSeason: (NSString *) season Episode: (NSString *) episode Full: (NSString *) full;

@end
