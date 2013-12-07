//
//  AvatarViewController.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 07/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoadableViewController.h"

@class User;
@interface AvatarViewController : LoadableViewController

@property(strong, nonatomic) User * user;
@property(strong, nonatomic) UIImageView * blurImageView;
@property(strong, nonatomic) UIImageView * avatarImageView;

- (id)initWithFrame:(CGRect)frame User: (User *) user;

@end
