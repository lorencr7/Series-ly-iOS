//
//  Episode.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 13/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Episode.h"
#import "EpisodeMedia.h"

@implementation Episode

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.idm = [dictionary objectForKey:@"idm"];
        NSString * stringMediaType = [dictionary objectForKey:@"mediaType"];
        self.mediaType = [stringMediaType intValue];
        self.title = [dictionary objectForKey:@"title"];
        self.title_es = [dictionary objectForKey:@"title_es"];
        self.season = [dictionary objectForKey:@"season"];
        self.episode = [dictionary objectForKey:@"episode"];
        self.timeStamp = [dictionary objectForKey:@"timeStamp"];
        NSString * stringHaveLinks = [dictionary objectForKey:@"haveLinks"];
        self.haveLinks = [stringHaveLinks boolValue];
        
        NSDictionary * mediaDictionary = [dictionary objectForKey:@"media"];
        self.media = [[EpisodeMedia alloc] initWithDictionary:mediaDictionary];
        
        NSString * stringWatched = [dictionary objectForKey:@"watched"];
        self.watched = [stringWatched boolValue];
    }
    return self;
}

@end
