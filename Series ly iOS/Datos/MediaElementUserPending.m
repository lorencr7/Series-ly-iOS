//
//  MediaElementUserPending.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MediaElementUserPending.h"
#import "Pending.h"

@implementation MediaElementUserPending




-(id) initWithIdm: (NSString *) idm IdMedia: (NSString *) idMedia MediaType: (NSString *) mediaType Name: (NSString *) name MainGenre: (NSString *) mainGenre Year: (NSString *) year Seasons: (NSString *) seasons Episodes: (NSString *) episodes Url: (NSString *) url Poster: (Poster *) poster Pending: (Pending *) pending {
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
        self.pending = pending;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSDictionary * pendingDictionary = [dictionary objectForKey:@"pending"];
        self.pending = [[Pending alloc] initWithDictionary:pendingDictionary];
    }
    return self;
}

@end
