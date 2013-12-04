//
//  UserToken.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MetaModel.h"

@interface UserToken : MetaModel

@property (strong, nonatomic) NSString * userToken;
@property (assign, nonatomic) long userExpiresDate;
@property (assign, nonatomic) int error;

- (id)initWithUserToken: (NSString *) userToken UserExpiresDate: (long) userExpiresDate Error: (int) error;


@end
