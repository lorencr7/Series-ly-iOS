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

@end
