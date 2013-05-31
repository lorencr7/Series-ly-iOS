//
//  MediaElement.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Serializable.h"
@class Poster,Pending;
@interface MediaElement : Serializable

@property (strong, nonatomic) NSString * idm;
@property (strong, nonatomic) NSString * idMedia;
@property (strong, nonatomic) NSString * mediaType;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * mainGenre;
@property (strong, nonatomic) NSString * year;
@property (assign, nonatomic) int seasons;
@property (assign, nonatomic) int episodes;
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) Poster * poster;
@property (strong, nonatomic) NSString * status;
@property (strong, nonatomic) Pending * pending;



@end
