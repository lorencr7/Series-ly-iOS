//
//  User.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 05/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "MetaModel.h"

@interface User : MetaModel

@property(strong, nonatomic) NSString * uid;
@property(strong, nonatomic) NSString * nick;
@property(strong, nonatomic) NSString * fullName;
@property(strong, nonatomic) NSString * name;
@property(strong, nonatomic) NSString * surnames;
@property(strong, nonatomic) NSString * email;
@property(strong, nonatomic) NSString * privacy;
@property(strong, nonatomic) NSString * birthDate;
@property(strong, nonatomic) NSString * gender;
@property(strong, nonatomic) NSString * postalCode;
@property(strong, nonatomic) NSString * lang;
@property(strong, nonatomic) NSString * description;
@property(strong, nonatomic) NSString * createdAt;
@property(strong, nonatomic) NSString * points;
@property(strong, nonatomic) NSString * imgUser;
@property(strong, nonatomic) NSString * country;

@end
