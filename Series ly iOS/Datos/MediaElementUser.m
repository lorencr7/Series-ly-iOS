//
//  MediaElementUser.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MediaElementUser.h"

@implementation MediaElementUser

-(id) initWithIdm: (NSString *) idm IdMedia: (NSString *) idMedia MediaType: (NSString *) mediaType Name: (NSString *) name MainGenre: (NSString *) mainGenre Year: (NSString *) year Seasons: (NSString *) seasons Episodes: (NSString *) episodes Url: (NSString *) url Poster: (Poster *) poster Status: (NSString *) status {
    self = [super init];
    if (self) {
        self.idm = [NSString stringWithFormat:@"%@",idm];
        self.idMedia = [NSString stringWithFormat:@"%@",idMedia];
        self.mediaType = [NSString stringWithFormat:@"%@",mediaType];
        self.name = [NSString stringWithFormat:@"%@",name];
        self.mainGenre = [NSString stringWithFormat:@"%@",mainGenre];
        self.year = [NSString stringWithFormat:@"%@",year];
        self.seasons = [NSString stringWithFormat:@"%@",seasons];
        self.episodes = [NSString stringWithFormat:@"%@",episodes];
        self.url = [NSString stringWithFormat:@"%@",url];
        self.poster = poster;
        self.status = [NSString stringWithFormat:@"%@",status];
    }
    return self;
}

@end
