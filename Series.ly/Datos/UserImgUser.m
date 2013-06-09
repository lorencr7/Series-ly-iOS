//
//  UserImgUser.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserImgUser.h"

@implementation UserImgUser

- (id)initWithBig: (NSString *) big Small: (NSString *) small {
    self = [super init];
    if (self) {
        self.big = big;
        self.small = small;
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.big = [dictionary objectForKey:@"big"];
        self.small = [dictionary objectForKey:@"small"];
    }
    return self;
}

@end
