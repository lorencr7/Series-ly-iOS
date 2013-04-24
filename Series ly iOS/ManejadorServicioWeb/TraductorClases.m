//
//  TraductorClases.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "TraductorClases.h"
#import "AuthToken.h"
#import "UserToken.h"
#import "UserExtInfo.h"
#import "UserData.h"
#import "UserCountry.h"
#import "UserImgUser.h"
#import "MediaElementUserPending.h"
#import "Poster.h"
#import "Pending.h"
#import "MediaElementUser.h"
#import "UserInfo.h"
#import "Link.h"
#import "Links.h"
#import "FullInfo.h"
#import "Director.h"
#import "Cast.h"
#import "Episode.h"
#import "EpisodeMedia.h"
#import "Season.h"
#import "SeasonsEpisodes.h"

static TraductorClases * instance;


@implementation TraductorClases

+(TraductorClases *) getInstance {
    if (instance == nil) {
        instance = [[TraductorClases alloc] init];
    }
    
    return instance;
}

/*-(AuthToken *) getAuthTokenFromDictionary: (NSDictionary *) dictionary {
    NSString * authToken = [dictionary objectForKey:@"auth_token"];
    NSString * authExpiresDateString = [dictionary objectForKey:@"auth_expires_date"];
    long authExpiresDate = [authExpiresDateString longLongValue];
    NSString * authErrorString = [dictionary objectForKey:@"error"];
    int authError = [authErrorString intValue];
    return [[AuthToken alloc] initWithAuthToken:authToken AuthExpiresDate:authExpiresDate Error:authError];
}*/

/*-(UserToken *) getUserTokenFromDictionary: (NSDictionary *) dictionary {
    NSString * userToken = [dictionary objectForKey:@"user_token"];
    NSString * userExpiresDateString = [dictionary objectForKey:@"user_expires_date"];
    long userExpiresDate = [userExpiresDateString longLongValue];
    NSString * userErrorString = [dictionary objectForKey:@"error"];
    int userError = [userErrorString intValue];
    return [[UserToken alloc] initWithUserToken:userToken UserExpiresDate:userExpiresDate Error:userError];
}*/

/*-(UserInfo *) getUserInfoFromDictionary: (NSDictionary *) dictionary {
    
    NSString * uid = [dictionary objectForKey:@"uid"];
    
    NSDictionary * extInfoDictionary =  [dictionary objectForKey:@"extInfo"];
    NSString * cp = [extInfoDictionary objectForKey:@"cp"];
    NSString * nom = [extInfoDictionary objectForKey:@"nom"];
    NSString * cognoms = [extInfoDictionary objectForKey:@"cognoms"];
    NSString * dataNaixement = [extInfoDictionary objectForKey:@"data_naixement"];
    NSString * sexe = [extInfoDictionary objectForKey:@"sexe"];
    NSString * veureNom = [extInfoDictionary objectForKey:@"veure_nom"];
    NSString * veureEmail = [extInfoDictionary objectForKey:@"veure_email"];
    NSString * lang = [extInfoDictionary objectForKey:@"lang"];
    NSString * userDescription = [extInfoDictionary objectForKey:@"user_description"];
    NSString * profesion = [extInfoDictionary objectForKey:@"profesion"];
    UserExtInfo * extInfo = [[UserExtInfo alloc] initWithCp:cp Nom:nom Cognoms:cognoms DataNaixement:dataNaixement Sexe:sexe VeureNom:veureNom VeureEmail:veureEmail Lang:lang UserDescription:userDescription Profesion:profesion];
    
    NSDictionary * userDataDictionary =  [dictionary objectForKey:@"userdata"];
    NSString * uidUserData = [userDataDictionary objectForKey:@"uid"];
    NSString * uidCodi = [userDataDictionary objectForKey:@"uid_codi"];
    NSString * nick = [userDataDictionary objectForKey:@"nick"];
    NSString * email = [userDataDictionary objectForKey:@"email"];
    NSString * dataAlta = [userDataDictionary objectForKey:@"data_alta"];
    NSString * punts = [userDataDictionary objectForKey:@"punts"];
    NSString * userAgentHash = [userDataDictionary objectForKey:@"user_agent_hash"];
    
    NSDictionary * imgUserDictionary = [userDataDictionary objectForKey:@"img_user"];
    NSString * big = [imgUserDictionary objectForKey:@"big"];
    NSString * small = [imgUserDictionary objectForKey:@"small"];
    UserImgUser * imgUser = [[UserImgUser alloc] initWithBig:big Small:small];
    
    NSDictionary * countryDictionary = [userDataDictionary objectForKey:@"country"];
    NSString * iso = [countryDictionary objectForKey:@"iso"];
    NSString * name = [countryDictionary objectForKey:@"name"];
    UserCountry * country =/Users/lorenzov/Documents/series-ly-iOS/Series ly iOS/MasterViewController.m [[UserCountry alloc] initWithIso:iso Name:name];
    
    UserData * userData = [[UserData alloc] initWithUid:uidUserData UidCodi:uidCodi Nick:nick Email:email DataAlta:dataAlta Punts:punts UserAgentHash:userAgentHash ImgUser:imgUser Country:country];
    NSString * error2 = [dictionary objectForKey:@"error"];
    int error = [error2 intValue];
    if (error != 0) {
        NSLog(@"error %d grabbing userInfo",error);
    }
    
    return [[UserInfo alloc] initWithUid:uid ExiInfo:extInfo UserData:userData Error:error];
}*/


/*-(MediaElementUserPending *) getMediaElementUserPendingFromDictionary: (NSDictionary *) dictionary {
    NSString * idm = [dictionary objectForKey:@"idm"];
    NSString * idMedia = [dictionary objectForKey:@"id_media"];
    NSString * mediaType = [dictionary objectForKey:@"mediaType"];
    NSString * name = [dictionary objectForKey:@"name"];
    NSString * mainGenre = [dictionary objectForKey:@"maingenre"];
    NSString * year = [dictionary objectForKey:@"year"];
    NSString * seasons = [dictionary objectForKey:@"seasons"];
    NSString * episodes = [dictionary objectForKey:@"episodes"];
    NSString * url = [dictionary objectForKey:@"url"];
    
    NSDictionary * posterDictionary = [dictionary objectForKey:@"poster"];
    NSString * large = [posterDictionary objectForKey:@"large"];
    NSString * medium = [posterDictionary objectForKey:@"medium"];
    NSString * small = [posterDictionary objectForKey:@"small"];
    Poster * poster = [[Poster alloc] initWithLarge:large Medium:medium Small:small];
    
    NSDictionary * pendingDictionary = [dictionary objectForKey:@"pending"];
    NSString * season = [pendingDictionary objectForKey:@"season"];
    NSString * episode = [pendingDictionary objectForKey:@"episode"];
    NSString * full = [pendingDictionary objectForKey:@"full"];
    Pending * pending = [[Pending alloc] initWithSeason:season Episode:episode Full:full];
    
    return [[MediaElementUserPending alloc] initWithIdm:idm IdMedia:idMedia MediaType:mediaType Name:name MainGenre:mainGenre Year:year Seasons:seasons Episodes:episodes Url:url Poster:poster Pending:pending];
}*/

/*-(MediaElementUser *) getMediaElementUserFromDictionary: (NSDictionary *) dictionary {
    NSString * idm = [dictionary objectForKey:@"idm"];
    NSString * idMedia = [dictionary objectForKey:@"id_media"];
    NSString * mediaType = [dictionary objectForKey:@"mediaType"];
    NSString * name = [dictionary objectForKey:@"name"];
    NSString * mainGenre = [dictionary objectForKey:@"maingenre"];
    NSString * year = [dictionary objectForKey:@"year"];
    NSString * seasons = [dictionary objectForKey:@"seasons"];
    NSString * episodes = [dictionary objectForKey:@"episodes"];
    NSString * url = [dictionary objectForKey:@"url"];
    
    NSDictionary * posterDictionary = [dictionary objectForKey:@"poster"];
    NSString * large = [posterDictionary objectForKey:@"large"];
    NSString * medium = [posterDictionary objectForKey:@"medium"];
    NSString * small = [posterDictionary objectForKey:@"small"];
    Poster * poster = [[Poster alloc] initWithLarge:large Medium:medium Small:small];
    
    NSString * status = [dictionary objectForKey:@"status"];
    
    return [[MediaElementUser alloc] initWithIdm:idm IdMedia:idMedia MediaType:mediaType Name:name MainGenre:mainGenre Year:year Seasons:seasons Episodes:episodes Url:url Poster:poster Status:status];
}*/

/*-(Links *) getLinksFromDictionary: (NSDictionary *) dictionary {
    NSArray * offialServerDictionary = [dictionary objectForKey:@"officialServer"];
    NSArray * streamingDictionary = [dictionary objectForKey:@"streaming"];
    NSArray * directDownloadDictionary = [dictionary objectForKey:@"direct_download"];
    NSString * error2 = [dictionary objectForKey:@"error"];
    int error = [error2 intValue];
    if (error != 0) {
        NSLog(@"error %d grabbing links",error);
    }
    NSMutableArray * officialServerLinks = [NSMutableArray array];
    NSMutableArray * streamingLinks = [NSMutableArray array];
    NSMutableArray * directDownloadLinks = [NSMutableArray array];
    
    for (NSDictionary * linkDictionary in offialServerDictionary) {
        NSString * idv = [linkDictionary objectForKey:@"idv"];
        NSString * host = [linkDictionary objectForKey:@"host"];
        NSString * lang = [linkDictionary objectForKey:@"lang"];
        NSString * subtitles = [linkDictionary objectForKey:@"subtitles"];
        NSString * videoUrl = [linkDictionary objectForKey:@"video_url"];
        NSString * dateCreated = [linkDictionary objectForKey:@"date_created"];
        NSString * price = [linkDictionary objectForKey:@"price"];
        NSString * quality = [linkDictionary objectForKey:@"quality"];
        NSString * addedBy = [linkDictionary objectForKey:@"added_by"];
        Link * link = [[Link alloc] initWithIdv:idv Host:host Lang:lang Subtitles:subtitles VideoUrl:videoUrl DateCreated:dateCreated Price:price Quality:quality AddedBy:addedBy];
        [officialServerLinks addObject:link];
    }
    
    for (NSDictionary * linkDictionary in streamingDictionary) {
        NSString * idv = [linkDictionary objectForKey:@"idv"];
        NSString * host = [linkDictionary objectForKey:@"host"];
        NSString * lang = [linkDictionary objectForKey:@"lang"];
        NSString * subtitles = [linkDictionary objectForKey:@"subtitles"];
        NSString * videoUrl = [linkDictionary objectForKey:@"video_url"];
        NSString * dateCreated = [linkDictionary objectForKey:@"date_created"];
        NSString * price = [linkDictionary objectForKey:@"price"];
        NSString * quality = [linkDictionary objectForKey:@"quality"];
        NSString * addedBy = [linkDictionary objectForKey:@"added_by"];
        Link * link = [[Link alloc] initWithIdv:idv Host:host Lang:lang Subtitles:subtitles VideoUrl:videoUrl DateCreated:dateCreated Price:price Quality:quality AddedBy:addedBy];
        [streamingLinks addObject:link];
    }
    
    for (NSDictionary * linkDictionary in directDownloadDictionary) {
        NSString * idv = [linkDictionary objectForKey:@"idv"];
        NSString * host = [linkDictionary objectForKey:@"host"];
        NSString * lang = [linkDictionary objectForKey:@"lang"];
        NSString * subtitles = [linkDictionary objectForKey:@"subtitles"];
        NSString * videoUrl = [linkDictionary objectForKey:@"video_url"];
        NSString * dateCreated = [linkDictionary objectForKey:@"date_created"];
        NSString * price = [linkDictionary objectForKey:@"price"];
        NSString * quality = [linkDictionary objectForKey:@"quality"];
        NSString * addedBy = [linkDictionary objectForKey:@"added_by"];
        Link * link = [[Link alloc] initWithIdv:idv Host:host Lang:lang Subtitles:subtitles VideoUrl:videoUrl DateCreated:dateCreated Price:price Quality:quality AddedBy:addedBy];
        [directDownloadLinks addObject:link];
    }
    Links * links = [[Links alloc] init];
    links.officialServer = officialServerLinks;
    links.streaming = streamingLinks;
    links.directDownload = directDownloadLinks;
    links.error = error;
    return links;
    
}*/

-(FullInfo *) getFullInfoFromDictionary: (NSDictionary *) dictionary {
    FullInfo * fullInfo = [[FullInfo alloc] init];
    fullInfo.idm = [dictionary objectForKey:@"idm"];
    fullInfo.idMedia = [dictionary objectForKey:@"id_media"];
    fullInfo.mediaType = [dictionary objectForKey:@"mediaType"];
    fullInfo.name = [dictionary objectForKey:@"name"];
    fullInfo.mainGenre = [dictionary objectForKey:@"maingenre"];
    fullInfo.year = [dictionary objectForKey:@"year"];
    fullInfo.seasons = [dictionary objectForKey:@"seasons"];
    fullInfo.episodes = [dictionary objectForKey:@"episodes"];
    
    NSDictionary * posterDictionary = [dictionary objectForKey:@"poster"];
    NSString * large = [posterDictionary objectForKey:@"large"];
    NSString * medium = [posterDictionary objectForKey:@"medium"];
    NSString * small = [posterDictionary objectForKey:@"small"];
    Poster * poster = [[Poster alloc] initWithLarge:large Medium:medium Small:small];
    fullInfo.poster = poster;
    
    fullInfo.keywords = [dictionary objectForKey:@"keywords"];
    fullInfo.runtime = [dictionary objectForKey:@"runtime"];
    fullInfo.country = [dictionary objectForKey:@"country"];
    fullInfo.genres = [dictionary objectForKey:@"genres"];
    
    NSMutableArray * directorsArray = [dictionary objectForKey:@"director"];
    NSMutableArray * directors = [NSMutableArray array];
    for (NSDictionary * directorDictionary in directorsArray) {
        Director * director = [[Director alloc] init];
        director.imdb = [directorDictionary objectForKey:@"imdb"];
        director.name = [directorDictionary objectForKey:@"name"];
        director.role = [directorDictionary objectForKey:@"role"];
        [directors addObject:director];
    }
    fullInfo.director = directors;
    
    NSMutableArray * castsArray = [dictionary objectForKey:@"cast"];
    NSMutableArray * casts = [NSMutableArray array];
    for (NSDictionary * castDictionary in castsArray) {
        Cast * cast = [[Cast alloc] init];
        cast.imdb = [castDictionary objectForKey:@"imdb"];
        cast.name = [castDictionary objectForKey:@"name"];
        cast.role = [castDictionary objectForKey:@"role"];
        [casts addObject:cast];
    }
    fullInfo.cast = casts;
    
    fullInfo.rating = [dictionary objectForKey:@"rating"];
    
    NSDictionary * seasonsEpisodesDictionary = [dictionary objectForKey:@"seasons_episodes"];
    NSMutableArray * seasonsEpisodesArray = [NSMutableArray array];
    int seasons = [fullInfo.seasons intValue], i;
    for (i = 0; i < seasons ; i++) {
        Season * season = [[Season alloc] init];
        NSString * seasonString;
        if (i < 10) {
            seasonString = [NSString stringWithFormat:@"0%d",i];
        } else {
            seasonString = [NSString stringWithFormat:@"%d",i];
        }
        NSString * key = [NSString stringWithFormat:@"season_%@",seasonString];
        NSArray * arrayCapitulosPorSesion = [seasonsEpisodesDictionary objectForKey:key];
        NSMutableArray * episodes = [NSMutableArray array];
        for (NSDictionary * diccionarioCapitulo in arrayCapitulosPorSesion) {
            Episode * episode = [[Episode alloc] init];
            episode.idm = [diccionarioCapitulo objectForKey:@"idm"];
            NSString * stringMediaType = [diccionarioCapitulo objectForKey:@"mediaType"];
            episode.mediaType = [stringMediaType intValue];
            episode.title = [diccionarioCapitulo objectForKey:@"title"];
            episode.title_es = [diccionarioCapitulo objectForKey:@"title_es"];
            episode.season = [diccionarioCapitulo objectForKey:@"season"];
            episode.episode = [diccionarioCapitulo objectForKey:@"episode"];
            episode.timeStamp = [diccionarioCapitulo objectForKey:@"timeStamp"];
            NSString * stringHaveLinks = [diccionarioCapitulo objectForKey:@"haveLinks"];
            episode.haveLinks = [stringHaveLinks boolValue];
            EpisodeMedia * episodeMedia = [[EpisodeMedia alloc] init];
            NSDictionary * mediaDictionary = [diccionarioCapitulo objectForKey:@"media"];
            episodeMedia.idm = [mediaDictionary objectForKey:@"idm"];
            episodeMedia.mediaType = [mediaDictionary objectForKey:@"mediaType"];
            episode.media = episodeMedia;
            [episodes addObject:episode];
        }
        season.episodes = episodes;
        [seasonsEpisodesArray addObject:season];
    }
    SeasonsEpisodes * seasonsEpisodes = [[SeasonsEpisodes alloc] init];
    seasonsEpisodes.seasons = seasonsEpisodesArray;
    fullInfo.seasonsEpisodes = seasonsEpisodes;
    fullInfo.plot = [dictionary objectForKey:@"plot"];
    fullInfo.plot_es = [dictionary objectForKey:@"plot_es"];
    fullInfo.plot_en = [dictionary objectForKey:@"plot_en"];
    NSString * stringError = [dictionary objectForKey:@"error"];
    fullInfo.error = [stringError intValue];
    
    return fullInfo;
}

@end
