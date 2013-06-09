//
//  UserData.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserData.h"
#import "UserImgUser.h"
#import "UserCountry.h"

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

-(id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.uid = [dictionary objectForKey:@"uid"];
        self.uidCodi = [dictionary objectForKey:@"uid_codi"];
        self.nick = [dictionary objectForKey:@"nick"];
        self.email = [dictionary objectForKey:@"email"];
        self.dataAlta = [dictionary objectForKey:@"data_alta"];
        self.punts = [dictionary objectForKey:@"punts"];
        self.userAgentHash = [dictionary objectForKey:@"user_agent_hash"];
        
        NSDictionary * imgUserDictionary = [dictionary objectForKey:@"img_user"];
        self.imgUser = [[UserImgUser alloc] initWithDictionary:imgUserDictionary];
        
        NSDictionary * countryDictionary = [dictionary objectForKey:@"country"];
        self.country = [[UserCountry alloc] initWithDictionary:countryDictionary];
    }
    return self;
    
}

@end
