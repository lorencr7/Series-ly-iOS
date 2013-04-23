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

@end
