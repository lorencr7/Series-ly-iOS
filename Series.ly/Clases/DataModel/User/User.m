//
//  User.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 05/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.uid = [dictionary objectForKey:@"uid"];
        self.nick = [dictionary objectForKey:@"nick"];
        self.fullName = [dictionary objectForKey:@"full_name"];
        self.surnames = [dictionary objectForKey:@"surnames"];
        self.email = [dictionary objectForKey:@"email"];
        self.privacy = [dictionary objectForKey:@"privacy"];
        self.birthDate = [dictionary objectForKey:@"birth_date"];
        self.gender = [dictionary objectForKey:@"gender"];
        self.postalCode = [dictionary objectForKey:@"postal_code"];
        self.lang = [dictionary objectForKey:@"lang"];
        self.description = [dictionary objectForKey:@"description"];
        self.createdAt = [dictionary objectForKey:@"created_at"];
        self.points = [dictionary objectForKey:@"points"];
        self.imgUser = [dictionary objectForKey:@"img_user"];
        self.country = [dictionary objectForKey:@"country"];
    }
    return self;
}

@end
