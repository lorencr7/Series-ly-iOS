//
//  UserCredentials.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserCredentials.h"

UserCredentials * instance;

@implementation UserCredentials

+(UserCredentials *) getInstance {
    if (instance == nil) {
        instance = [[UserCredentials alloc] init];
    }
    
    return instance;
}

+(void) resetInstance {
    instance = nil;
}


- (id)initWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    self = [super init];
    if (self) {
        self.authToken = authToken;
        self.userToken = userToken;
    }
    return self;
}

@end
