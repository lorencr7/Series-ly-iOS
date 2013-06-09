//
//  Cast.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 13/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Serializable.h"
@interface Cast : Serializable

@property (strong,nonatomic) NSString * imdb;
@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSString * role;

@end
