//
//  MediaElement.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MediaElement.h"
#import "Poster.h"
#import "Pending.h"

@implementation MediaElement

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.idm = [dictionary objectForKey:@"idm"];
        NSString * idMedia2 = [dictionary objectForKey:@"id_media"];
        self.idMedia = [idMedia2 intValue];
        NSString * mediaType2 = [dictionary objectForKey:@"mediaType"];
        self.mediaType = [mediaType2 intValue];
        self.name = [dictionary objectForKey:@"name"];
        self.mainGenre = [dictionary objectForKey:@"maingenre"];
        NSString * year2 = [dictionary objectForKey:@"year"];
        self.year = [year2 intValue];
        NSString * seasons2 = [dictionary objectForKey:@"seasons"];
        self.seasons = [seasons2 intValue];
        NSString * episodes2 = [dictionary objectForKey:@"episodes"];
        self.episodes = [episodes2 intValue];
        self.url = [dictionary objectForKey:@"url"];
        
        NSDictionary * posterDictionary = [dictionary objectForKey:@"poster"];
        self.poster = [[Poster alloc] initWithDictionary:posterDictionary];
        
        self.status = [dictionary objectForKey:@"status"];
        
        NSDictionary * pendingDictionary = [dictionary objectForKey:@"pending"];
        self.pending = [[Pending alloc] initWithDictionary:pendingDictionary];
    }
    return self;
}

-(BOOL) isEqual:(id)object {
    if ([object class] != [self class]) {
        return NO;
    }
    MediaElement * mediaElementUser = (MediaElement *) object;
    if (self.idm == mediaElementUser.idm && self.idMedia == mediaElementUser.idMedia) {
        return YES;
    }
    
    return NO;
}

@end
