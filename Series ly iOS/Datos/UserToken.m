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

-(NSString *) description {
    return [NSString stringWithFormat:@"UserToken = %@, UserExpiresDate = %ld",self.userToken,self.userExpiresDate];
}


@end
