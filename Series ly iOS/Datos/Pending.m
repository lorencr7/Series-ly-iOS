//
//  Pending.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Pending.h"

@implementation Pending

- (id)initWithSeason: (NSString *) season Episode: (NSString *) episode Full: (NSString *) full {
    self = [super init];
    if (self) {
        self.season = [NSString stringWithFormat:@"%@",season];
        self.episode = [NSString stringWithFormat:@"%@",episode];
        self.full = [NSString stringWithFormat:@"%@",full];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.season = [pendingDictionary objectForKey:@"season"];
        self.episode = [pendingDictionary objectForKey:@"episode"];
        NSString * full = [pendingDictionary objectForKey:@"full"];
    }
    return self;
}

@end
