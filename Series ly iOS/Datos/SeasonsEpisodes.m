//
//  SeasonsEpisodes.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 13/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "SeasonsEpisodes.h"
#import "Season.h"
#import "Episode.h"

@implementation SeasonsEpisodes

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSLog(@"numberOfSeasons: %d",dictionary.count);
        
        self.seasons = [NSMutableArray array];
        int seasons = dictionary.count , i;
        for (i = 0; i < seasons ; i++) {
            Season * season = [[Season alloc] init];
            NSString * seasonString;
            if (i < 10) {
                seasonString = [NSString stringWithFormat:@"0%d",i];
            } else {
                seasonString = [NSString stringWithFormat:@"%d",i];
            }
            NSString * key = [NSString stringWithFormat:@"season_%@",seasonString];
            NSArray * arrayCapitulosPorSesion = [dictionary objectForKey:key];
            NSMutableArray * episodes = [NSMutableArray array];
            for (NSDictionary * diccionarioCapitulo in arrayCapitulosPorSesion) {
                
                [episodes addObject:[[Episode alloc] initWithDictionary:diccionarioCapitulo]];
            }
            season.episodes = episodes;
            [self.seasons addObject:season];
        }
    }
    return self;
}

@end
