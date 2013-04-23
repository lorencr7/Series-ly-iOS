//
//  UserData.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Serializable.h"

@class UserImgUser,UserCountry;
@interface UserData : Serializable

@property (strong,nonatomic) NSString * uid;
@property (strong,nonatomic) NSString * uidCodi;
@property (strong,nonatomic) NSString * nick;
@property (strong,nonatomic) NSString * email;
@property (strong,nonatomic) NSString * dataAlta;
@property (strong,nonatomic) NSString * punts;
@property (strong,nonatomic) NSString * userAgentHash;
@property (strong,nonatomic) UserImgUser * imgUser;
@property (strong,nonatomic) UserCountry * country;

- (id)initWithUid: (NSString *) uid UidCodi: (NSString *) uidCodi Nick: (NSString *) nick Email: (NSString *) email DataAlta: (NSString *) dataAlta Punts: (NSString *) punts UserAgentHash: (NSString *) userAgentHash ImgUser: (UserImgUser *) imgUser Country: (UserCountry *) country;

@end
