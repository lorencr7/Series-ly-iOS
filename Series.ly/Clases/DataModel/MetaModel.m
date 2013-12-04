//
//  MetaModel.m
//  hooola
//
//  Created by Lorenzo Villarroel Pérez on 18/07/13.
//  Copyright (c) 2013 jobssy. All rights reserved.
//

#import "MetaModel.h"

@implementation MetaModel

- (id)initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSMutableDictionary *) getDictionary {
    return nil;
}

-(void) addObject: (id) object ToDictionary: (NSMutableDictionary *) dictionary Key: (NSString *) key {
    if (object && ([object class] != [NSNull class])) {
        if (!dictionary) {
            dictionary = [NSMutableDictionary dictionary];
        }
        dictionary[key] = object;
    }
}


@end
