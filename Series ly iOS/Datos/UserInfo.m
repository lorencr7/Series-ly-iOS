//
//  UserInfo.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 10/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserInfo.h"

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

@end
