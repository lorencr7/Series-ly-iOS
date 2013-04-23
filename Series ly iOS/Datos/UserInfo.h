//
//  UserInfo.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 10/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserExtInfo,UserData;
@interface UserInfo : NSObject

@property (strong,nonatomic) NSString * uid;
@property (strong,nonatomic) UserExtInfo * extInfo;
@property (strong,nonatomic) UserData * userData;
@property (assign,nonatomic) int error;

- (id)initWithUid: (NSString *) uid ExiInfo: (UserExtInfo *) extInfo UserData: (UserData *) userData Error: (int) error;


@end
