//
//  UserCountry.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserCountry.h"

@implementation UserCountry

- (id)initWithIso: (NSString *) iso Name: (NSString *) name {
    self = [super init];
    if (self) {
        self.iso = iso;
        self.name = name;
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.iso = [dictionary objectForKey:@"iso"];
        self.name = [dictionary objectForKey:@"name"];
    }
    return self;
}

@end
