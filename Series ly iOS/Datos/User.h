//
//  User.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;
@interface User : NSObject

@property (strong,nonatomic) UserInfo * userInfo;
@property (strong,nonatomic) NSMutableArray * seriesPendientes;
@property (strong,nonatomic) NSMutableArray * peliculasPendientes;
@property (strong,nonatomic) NSMutableArray * tvShowsPendientes;
@property (strong,nonatomic) NSMutableArray * documentalesPendientes;
@property (strong,nonatomic) NSMutableArray * seriesFollowing;
@property (strong,nonatomic) NSMutableArray * peliculasFollowing;
@property (strong,nonatomic) NSMutableArray * tvShowsFollowing;
@property (strong,nonatomic) NSMutableArray * documentalesFollowing;



@end
