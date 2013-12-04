//
//  MetaModel.h
//  hooola
//
//  Created by Lorenzo Villarroel Pérez on 18/07/13.
//  Copyright (c) 2013 jobssy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetaModel : NSObject

- (id)initWithDictionary: (NSDictionary *) dictionary;
-(NSMutableDictionary *) getDictionary;
-(void) addObject: (id) object ToDictionary: (NSMutableDictionary *) dictionary Key: (NSString *) key;

@end
