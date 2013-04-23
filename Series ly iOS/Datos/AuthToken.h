//
//  AuthToken.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthToken : NSObject

@property (strong, nonatomic) NSString * authToken;
@property (assign, nonatomic) long authExpiresDate;
@property (assign, nonatomic) int error;

- (id)initWithAuthToken: (NSString *) authToken AuthExpiresDate: (long) authExpiresDate Error: (int) error;

@end
