//
//  EpisodeMedia.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 13/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "EpisodeMedia.h"

@implementation EpisodeMedia

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.idm = [dictionary objectForKey:@"idm"];
        self.mediaType = [dictionary objectForKey:@"mediaType"];
    }
    return self;
}

@end
