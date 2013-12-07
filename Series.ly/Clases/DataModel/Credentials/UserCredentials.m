//
//  UserCredentials.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserCredentials.h"
#import "AuthToken.h"
#import "UserToken.h"

UserCredentials * instance;

@implementation UserCredentials

+(UserCredentials *) getInstance {
    if (instance == nil) {
        instance = [[UserCredentials alloc] init];
    }
    
    return instance;
}

+(void) setInstance: (id) newInstance {
    instance = newInstance;
}


+(void) resetInstance {
    instance = nil;
}

- (id)initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.authToken = [[AuthToken alloc] initWithDictionary:dictionary[@"authToken"]];
        self.userToken = [[UserToken alloc] initWithDictionary:dictionary[@"userToken"]];
    }
    return self;
}

-(NSMutableDictionary *) getDictionary {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[@"authToken"] = [self.authToken getDictionary];
    dictionary[@"userToken"] = [self.userToken getDictionary];
    return dictionary;
}


- (id)initWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    self = [super init];
    if (self) {
        self.authToken = authToken;
        self.userToken = userToken;
    }
    return self;
}

- (id)initWithCoder: (NSCoder *)coder {
    UserCredentials * credentials = [[UserCredentials alloc] init];
    credentials.authToken = [coder decodeObjectForKey:@"authToken"];
    credentials.userToken = [coder decodeObjectForKey:@"userToken"];
    return credentials;
    
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.authToken) {
        [coder encodeObject:self.authToken forKey:@"authToken"];
    }
    if (self.userToken) {
        [coder encodeObject:self.userToken forKey:@"userToken"];
    }
}

@end
