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
@property (strong, nonatomic) NSNumber * userExpiresDate;
@property (strong, nonatomic) NSNumber * error;

- (id)initWithUserToken: (NSString *) userToken UserExpiresDate: (NSNumber *) userExpiresDate Error: (NSNumber *) error;


@end
