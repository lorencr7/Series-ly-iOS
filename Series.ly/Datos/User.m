//
//  User.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "User.h"

static User * instance;

@implementation User

+(User *) getInstance {
    if (instance == nil) {
        instance = [[User alloc] init];
    }
    
    return instance;
}

+(void) resetInstance {
    instance = nil;
}

@end
