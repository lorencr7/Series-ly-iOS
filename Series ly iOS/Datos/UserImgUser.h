//
//  UserImgUser.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserImgUser : NSObject

@property (strong,nonatomic) NSString * big;
@property (strong,nonatomic) NSString * small;

- (id)initWithBig: (NSString *) big Small: (NSString *) small;

@end
