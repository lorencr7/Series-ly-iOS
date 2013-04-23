//
//  UserToken.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserToken.h"

@implementation UserToken

- (id)initWithUserToken: (NSString *) userToken UserExpiresDate: (long) userExpiresDate Error: (int) error {
    self = [super init];
    if (self) {
        self.userToken = userToken;
        self.userExpiresDate = userExpiresDate;
        self.error = error;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.userToken = [dictionary objectForKey:@"user_token"];
        
        NSString * userExpiresDateString = [dictionary objectForKey:@"user_expires_date"];
        self.userExpiresDate = [userExpiresDateString longLongValue];
        
        NSString * userErrorString = [dictionary objectForKey:@"error"];
        self.error = [userErrorString intValue];
    }
    return self;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"UserToken = %@, UserExpiresDate = %ld",self.userToken,self.userExpiresDate];
}


@end
