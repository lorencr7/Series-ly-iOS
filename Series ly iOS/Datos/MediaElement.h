//
//  MediaElement.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Poster;
@interface MediaElement : NSObject

@property (strong, nonatomic) NSString * idm;
@property (strong, nonatomic) NSString * idMedia;
@property (strong, nonatomic) NSString * mediaType;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * mainGenre;
@property (strong, nonatomic) NSString * year;
@property (strong, nonatomic) NSString * seasons;
@property (strong, nonatomic) NSString * episodes;
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) Poster * poster;



@end
