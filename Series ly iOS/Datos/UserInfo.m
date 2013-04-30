//
//  UserInfo.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 10/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserInfo.h"
#import "UserExtInfo.h"
#import "UserData.h"
#import "PerfilViewController.h"

@implementation UserInfo

- (id)initWithUid: (NSString *) uid ExiInfo: (UserExtInfo *) extInfo UserData: (UserData *) userData Error: (int) error {
    self = [super init];
    if (self) {
        self.uid = uid;
        self.extInfo = extInfo;
        self.userData = userData;
        self.error = error;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.uid = [dictionary objectForKey:@"uid"];
        
        NSDictionary * extInfoDictionary =  [dictionary objectForKey:@"extInfo"];
        self.extInfo = [[UserExtInfo alloc] initWithDictionary:extInfoDictionary];
        
        NSDictionary * userDataDictionary =  [dictionary objectForKey:@"userdata"];
        self.userData = [[UserData alloc] initWithDictionary:userDataDictionary];
        
        NSString * error2 = [dictionary objectForKey:@"error"];
        self.error = [error2 intValue];
        if (self.error != 0) {
            if (self.error == 7) {
                [PerfilViewController logout];
            }
            NSLog(@"error %d grabbing userInfo",self.error);
        }
    }
    return self;
}

@end
