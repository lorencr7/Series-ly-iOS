//
//  AuthToken.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "AuthToken.h"

@implementation AuthToken

- (id)initWithAuthToken: (NSString *) authToken AuthExpiresDate: (NSNumber *) authExpiresDate Error: (NSNumber *) error {
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
        
        //NSString * extireDate = [dictionary objectForKey:@"auth_expires_date"];
        //NSLog(@"%@",extireDate.class);
        self.authExpiresDate = [dictionary objectForKey:@"auth_expires_date"];
        //self.authExpiresDate = [dictionary objectForKey:@"auth_expires_date"];
        //NSLog(@"expire date: %ld",self.authExpiresDate.longValue);
        NSString * error = [dictionary objectForKey:@"error"];
        self.error = [NSNumber numberWithLongLong:[error intValue]];
    }
    return self;
}

-(NSMutableDictionary *) getDictionary {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    [self addObject:self.authToken ToDictionary:dictionary Key:@"auth_token"];
    [self addObject:self.authExpiresDate ToDictionary:dictionary Key:@"auth_expires_date"];
    [self addObject:self.error ToDictionary:dictionary Key:@"error"];
    return dictionary;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"AuthToken = %@, AuthExpiresDate = %ld, AuthError = %d",self.authToken,self.authExpiresDate.longValue,self.error.intValue];
    //return @"";
}

- (id)initWithCoder: (NSCoder *)coder {
    AuthToken * authToken = [[AuthToken alloc] init];
    authToken.authToken = [coder decodeObjectForKey:@"authToken"];
    authToken.authExpiresDate = [coder decodeObjectForKey:@"authExpiresDate"];
    authToken.error = [coder decodeObjectForKey:@"error"];
    return authToken;
    
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.authToken) {
        [coder encodeObject:self.authToken forKey:@"authToken"];
    }
    if (self.authExpiresDate) {
        [coder encodeObject:self.authExpiresDate forKey:@"authExpiresDate"];
    }
    if (self.error) {
        [coder encodeObject:self.error forKey:@"error"];
    }
    
}

@end
