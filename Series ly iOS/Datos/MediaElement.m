//
//  MediaElement.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MediaElement.h"
#import "Poster.h"

@implementation MediaElement

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.idm = [dictionary objectForKey:@"idm"];
        self.idMedia = [dictionary objectForKey:@"id_media"];
        self.mediaType = [dictionary objectForKey:@"mediaType"];
        self.name = [dictionary objectForKey:@"name"];
        self.mainGenre = [dictionary objectForKey:@"maingenre"];
        self.year = [dictionary objectForKey:@"year"];
        self.seasons = [dictionary objectForKey:@"seasons"];
        self.episodes = [dictionary objectForKey:@"episodes"];
        self.url = [dictionary objectForKey:@"url"];
        
        NSDictionary * posterDictionary = [dictionary objectForKey:@"poster"];
        self.poster = [[Poster alloc] initWithDictionary:posterDictionary];
    }
    return self;
}

@end
