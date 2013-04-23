//
//  Poster.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Poster.h"

@implementation Poster

- (id)initWithLarge: (NSString *) large Medium: (NSString *) medium Small: (NSString *) small {
    self = [super init];
    if (self) {
        self.large = [NSString stringWithFormat:@"%@",large];
        self.medium = [NSString stringWithFormat:@"%@",medium];
        self.small = [NSString stringWithFormat:@"%@",small];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.large = [dictionary objectForKey:@"large"];
        self.medium = [dictionary objectForKey:@"medium"];
        self.small = [dictionary objectForKey:@"small"];
    }
    return self;
}

@end
