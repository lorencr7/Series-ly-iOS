//
//  UserCountry.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Serializable.h"

@interface UserCountry : Serializable

@property (strong,nonatomic) NSString * iso;
@property (strong,nonatomic) NSString * name;

- (id)initWithIso: (NSString *) iso Name: (NSString *) name;

@end
