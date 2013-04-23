//
//  UserCredentials.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthToken, UserToken;
@interface UserCredentials : NSObject

@property(strong, nonatomic) AuthToken * authToken;
@property(strong, nonatomic) UserToken * userToken;

- (id)initWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;

@end
