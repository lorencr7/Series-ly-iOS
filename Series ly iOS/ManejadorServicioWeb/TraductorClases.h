//
//  TraductorClases.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthToken,UserToken,UserInfo,MediaElementUserPending,MediaElementUser,Links,FullInfo;
@interface TraductorClases : NSObject

+(TraductorClases *) getInstance;

//-(AuthToken *) getAuthTokenFromDictionary: (NSDictionary *) dictionary;
//-(UserToken *) getUserTokenFromDictionary: (NSDictionary *) dictionary;
//-(UserInfo *) getUserInfoFromDictionary: (NSDictionary *) dictionary;
//-(MediaElementUserPending *) getMediaElementUserPendingFromDictionary: (NSDictionary *) dictionary;
//-(MediaElementUser *) getMediaElementUserFromDictionary: (NSDictionary *) dictionary;
//-(Links *) getLinksFromDictionary: (NSDictionary *) dictionary;
-(FullInfo *) getFullInfoFromDictionary: (NSDictionary *) dictionary;

@end
