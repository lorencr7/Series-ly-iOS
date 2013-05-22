//
//  Link.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Link.h"

@implementation Link

-(id) initWithIdv: (NSString *) idv Host: (NSString *) host Lang: (NSString *) lang Subtitles: (NSString *) subtitles VideoUrl: (NSString *) videoUrl DateCreated: (NSString *) dateCreated Price: (NSString *) price Quality: (NSString *) quality AddedBy: (NSString *) addedBy {
    self = [super init];
    if (self) {
        self.idv = idv;
        self.host = host;
        self.lang = lang;
        self.subtitles = subtitles;
        self.videoUrl = videoUrl;
        self.dateCreated = dateCreated;
        self.price = price;
        self.quality = quality;
        self.addedBy = addedBy;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.idv = [dictionary objectForKey:@"idv"];
        self.host = [dictionary[@"host"] class] == [NSNull class] ? nil : dictionary[@"host"];
        //self.host = [dictionary objectForKey:@"host"];
        self.lang = [dictionary objectForKey:@"lang"];
        self.subtitles = [dictionary objectForKey:@"subtitles"];
        self.videoUrl = [dictionary objectForKey:@"video_url"];
        self.dateCreated = [dictionary objectForKey:@"date_created"];
        self.price = [dictionary objectForKey:@"price"];
        self.quality = [dictionary objectForKey:@"quality"];
        self.addedBy = [dictionary objectForKey:@"added_by"];
    }
    return self;
}

@end
