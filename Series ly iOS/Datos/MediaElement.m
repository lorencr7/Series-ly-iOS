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
        NSString * seasons2 = [dictionary objectForKey:@"seasons"];
        self.seasons = [seasons2 intValue];
        NSString * episodes2 = [dictionary objectForKey:@"episodes"];
        self.episodes = [episodes2 intValue];
        self.url = [dictionary objectForKey:@"url"];
        
        NSDictionary * posterDictionary = [dictionary objectForKey:@"poster"];
        self.poster = [[Poster alloc] initWithDictionary:posterDictionary];
    }
    return self;
}

@end
