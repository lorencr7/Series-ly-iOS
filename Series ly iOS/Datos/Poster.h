//
//  Poster.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Poster : NSObject

@property (strong, nonatomic) NSString * large;
@property (strong, nonatomic) NSString * medium;
@property (strong, nonatomic) NSString * small;

- (id)initWithLarge: (NSString *) large Medium: (NSString *) medium Small: (NSString *) small;

@end
