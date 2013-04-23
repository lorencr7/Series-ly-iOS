//
//  Episode.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 13/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EpisodeMedia;
@interface Episode : NSObject

@property (strong,nonatomic) NSString * idm;
@property (assign,nonatomic) int mediaType;
@property (strong,nonatomic) NSString * title;
@property (strong,nonatomic) NSString * title_es;
@property (strong,nonatomic) NSString * season;
@property (strong,nonatomic) NSString * episode;
@property (strong,nonatomic) NSString * timeStamp;
@property (assign,nonatomic) BOOL haveLinks;
@property (strong,nonatomic) EpisodeMedia * media;
@end
