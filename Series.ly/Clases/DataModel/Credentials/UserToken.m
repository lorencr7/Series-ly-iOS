//
//  UserToken.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserToken.h"

@implementation UserToken

- (id)initWithUserToken: (NSString *) userToken UserExpiresDate: (NSNumber *) userExpiresDate Error: (NSNumber *) error {
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
        
        NSString * extireDate = [dictionary objectForKey:@"user_expires_date"];
        self.userExpiresDate = [NSNumber numberWithLongLong:[extireDate longLongValue]];
        
        NSString * error = [dictionary objectForKey:@"error"];
        self.error = [NSNumber numberWithLongLong:[error intValue]];
    }
    return self;
}

-(NSMutableDictionary *) getDictionary {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    [self addObject:self.userToken ToDictionary:dictionary Key:@"user_token"];
    [self addObject:self.userExpiresDate ToDictionary:dictionary Key:@"user_expires_date"];
    [self addObject:self.error ToDictionary:dictionary Key:@"error"];
    return dictionary;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"UserToken = %@, UserExpiresDate = %ld",self.userToken,self.userExpiresDate.longValue];
}

- (id)initWithCoder: (NSCoder *)coder {
    UserToken * userToken = [[UserToken alloc] init];
    userToken.userToken = [coder decodeObjectForKey:@"userToken"];
    userToken.userExpiresDate = [coder decodeObjectForKey:@"userExpiresDate"];
    userToken.error = [coder decodeObjectForKey:@"error"];
    return userToken;
    
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.userToken) {
        [coder encodeObject:self.userToken forKey:@"userToken"];
    }
    if (self.userExpiresDate) {
        [coder encodeObject:self.userExpiresDate forKey:@"userExpiresDate"];
    }
    if (self.error) {
        [coder encodeObject:self.error forKey:@"error"];
    }
    
}


@end
