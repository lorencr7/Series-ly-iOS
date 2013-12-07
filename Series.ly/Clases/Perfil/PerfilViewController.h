//
//  PerfilViewController.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoadableViewController.h"

@class AvatarViewController,User;
@interface PerfilViewController : LoadableViewController

@property(strong, nonatomic) User * user;

@property(strong, nonatomic) AvatarViewController * avatarViewController;

@end
