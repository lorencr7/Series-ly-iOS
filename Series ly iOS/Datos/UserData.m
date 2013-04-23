//
//  UserData.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserData.h"

@implementation UserData

- (id)initWithUid: (NSString *) uid UidCodi: (NSString *) uidCodi Nick: (NSString *) nick Email: (NSString *) email DataAlta: (NSString *) dataAlta Punts: (NSString *) punts UserAgentHash: (NSString *) userAgentHash ImgUser: (UserImgUser *) imgUser Country: (UserCountry *) country {
    self = [super init];
    if (self) {
        self.uid = uid;
        self.uidCodi = uidCodi;
        self.nick = nick;
        self.email = email;
        self.dataAlta = dataAlta;
        self.punts = punts;
        self.userAgentHash = userAgentHash;
        self.imgUser = imgUser;
        self.country = country;
    }
    return self;
}

@end
