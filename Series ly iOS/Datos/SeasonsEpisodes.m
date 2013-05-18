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
        
        self.seasons = [NSMutableArray array];
        int seasons = dictionary.count , i, j = 0;
        for (i = 0; i < seasons ; i++) {
            Season * season = [[Season alloc] init];
            NSString * seasonString;
            if (i < 10) {
                seasonString = [NSString stringWithFormat:@"0%d",j];
            } else {
                seasonString = [NSString stringWithFormat:@"%d",j];
            }
            NSString * key = [NSString stringWithFormat:@"season_%@",seasonString];
            
            NSArray * arrayCapitulosPorSesion = [dictionary objectForKey:key];
            if (arrayCapitulosPorSesion) {
                NSMutableArray * episodes = [NSMutableArray array];
                for (NSDictionary * diccionarioCapitulo in arrayCapitulosPorSesion) {
                    
                    [episodes addObject:[[Episode alloc] initWithDictionary:diccionarioCapitulo]];
                }
                season.episodes = episodes;
                season.season = seasonString;
                [self.seasons addObject:season];
            } else {
                i--;
            }
            //NSLog(@"%@",arrayCapitulosPorSesion);
            
            j++;
        }
    }
    return self;
}

@end
