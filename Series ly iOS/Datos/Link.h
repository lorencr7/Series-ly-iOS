//
//  Link.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Link : NSObject

@property(strong,nonatomic) NSString * idv;
@property(strong,nonatomic) NSString * host;
@property(strong,nonatomic) NSString * lang;
@property(strong,nonatomic) NSString * subtitles;
@property(strong,nonatomic) NSString * videoUrl;
@property(strong,nonatomic) NSString * dateCreated;
@property(strong,nonatomic) NSString * price;
@property(strong,nonatomic) NSString * quality;
@property(strong,nonatomic) NSString * addedBy;

-(id) initWithIdv: (NSString *) idv Host: (NSString *) host Lang: (NSString *) lang Subtitles: (NSString *) subtitles VideoUrl: (NSString *) videoUrl DateCreated: (NSString *) dateCreated Price: (NSString *) price Quality: (NSString *) quality AddedBy: (NSString *) addedBy;

@end
