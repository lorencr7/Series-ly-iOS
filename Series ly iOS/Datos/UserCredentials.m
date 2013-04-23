//
//  UserCredentials.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserCredentials.h"

@implementation UserCredentials

- (id)initWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    self = [super init];
    if (self) {
        self.authToken = authToken;
        self.userToken = userToken;
    }
    return self;
}

@end
