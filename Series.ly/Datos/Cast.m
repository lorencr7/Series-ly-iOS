//
//  Cast.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 13/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Cast.h"

@implementation Cast

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.imdb = [dictionary objectForKey:@"imdb"];
        self.name = [dictionary objectForKey:@"name"];
        self.role = [dictionary objectForKey:@"role"];
    }
    return self;
}

@end
