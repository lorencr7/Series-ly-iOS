//
//  AuthToken.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "AuthToken.h"

@implementation AuthToken

- (id)initWithAuthToken: (NSString *) authToken AuthExpiresDate: (long) authExpiresDate Error: (int) error {
    self = [super init];
    if (self) {
        self.authToken = authToken;
        self.authExpiresDate = authExpiresDate;
        self.error = error;
    }
    return self;
}

- (id)initWithDictionary: (NSDictionary *) dictionary{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.authToken = [dictionary objectForKey:@"auth_token"];
        
        NSString * authExpiresDateString = [dictionary objectForKey:@"auth_expires_date"];
        self.authExpiresDate = [authExpiresDateString longLongValue];
        
        NSString * authErrorString = [dictionary objectForKey:@"error"];
        self.error = [authErrorString intValue];
    }
    return self;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"AuthToken = %@, AuthExpiresDate = %ld, AuthError = %d",self.authToken,self.authExpiresDate,self.error];
}

@end
