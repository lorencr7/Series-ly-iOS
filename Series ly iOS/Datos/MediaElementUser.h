//
//  MediaElementUser.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 01/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MediaElement.h"

@interface MediaElementUser : MediaElement

@property (strong, nonatomic) NSString * status;

-(id) initWithIdm: (NSString *) idm IdMedia: (NSString *) idMedia MediaType: (NSString *) mediaType Name: (NSString *) name MainGenre: (NSString *) mainGenre Year: (NSString *) year Seasons: (NSString *) seasons Episodes: (NSString *) episodes Url: (NSString *) url Poster: (Poster *) poster Status: (NSString *) status;

@end
