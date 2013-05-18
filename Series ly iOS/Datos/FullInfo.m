//
//  FullInfo.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 13/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "FullInfo.h"
#import "Director.h"
#import "Cast.h"
#import "SeasonsEpisodes.h"

@implementation FullInfo

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.keywords = [dictionary objectForKey:@"keywords"];
        self.runtime = [dictionary objectForKey:@"runtime"];
        self.country = [dictionary objectForKey:@"country"];
        self.genres = [dictionary objectForKey:@"genres"];
        
        NSMutableArray * directorsArray = [dictionary objectForKey:@"director"];
        self.director = [NSMutableArray array];
        for (NSDictionary * directorDictionary in directorsArray) {
            [self.director addObject:[[Director alloc] initWithDictionary:directorDictionary]];
        }
        
        NSMutableArray * castsArray = [dictionary objectForKey:@"cast"];
        self.cast = [NSMutableArray array];
        for (NSDictionary * castDictionary in castsArray) {
            [self.cast addObject:[[Cast alloc] initWithDictionary:castDictionary]];
        }
        
        self.rating = [dictionary objectForKey:@"rating"];
        
        NSDictionary * seasonsEpisodesDictionary = [dictionary objectForKey:@"seasons_episodes"];
        if (seasonsEpisodesDictionary) {
            self.seasonsEpisodes = [[SeasonsEpisodes alloc] initWithDictionary:seasonsEpisodesDictionary];
        }
        
        self.plot = [dictionary objectForKey:@"plot"];
        self.plot_es = [dictionary objectForKey:@"plot_es"];
        self.plot_en = [dictionary objectForKey:@"plot_en"];
        NSString * stringError = [dictionary objectForKey:@"error"];
        self.error = [stringError intValue];
        
        
        
    }
    return self;
}

@end
