//
//  FullInfo.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 13/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "MediaElement.h"

@class SeasonsEpisodes;
@interface FullInfo : MediaElement

@property (strong,nonatomic) NSMutableArray * keywords;
@property (strong,nonatomic) NSString * runtime;
@property (strong,nonatomic) NSMutableArray * languages;
@property (strong,nonatomic) NSMutableArray * country;
@property (strong,nonatomic) NSMutableArray * genres;
@property (strong,nonatomic) NSMutableArray * director;
@property (strong,nonatomic) NSMutableArray * cast;
@property (strong,nonatomic) NSString * rating;
@property (strong,nonatomic) SeasonsEpisodes * seasonsEpisodes;
@property (strong,nonatomic) NSString * plot;
@property (strong,nonatomic) NSString * plot_es;
@property (strong,nonatomic) NSString * plot_en;
@property (assign,nonatomic) int error;

@end
