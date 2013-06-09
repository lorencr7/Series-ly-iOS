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
    if ([self.idm isEqualToString:mediaElementUser.idm] && [self.idMedia isEqualToString:mediaElementUser.idMedia]) {
        return YES;
    }
    
    return NO;
}

@end
