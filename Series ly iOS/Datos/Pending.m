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
        //self.season = [NSString stringWithFormat:@"%@",season];
        self.episode = [NSString stringWithFormat:@"%@",episode];
        self.full = [NSString stringWithFormat:@"%@",full];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSString * season2 = [dictionary objectForKey:@"season"];
        self.season = [season2 intValue];
        self.episode = [dictionary objectForKey:@"episode"];
        self.full = [dictionary objectForKey:@"full"];
    }
    return self;
}

-(BOOL) isEqual:(id)object {
    if ([object class] != [self class]) {
        return NO;
    }
    Pending * pending = (Pending *) object;
    
    return pending.season == self.season && [pending.episode isEqualToString:self.episode] && [pending.full isEqualToString:self.full];
    
    return NO;
}

@end
