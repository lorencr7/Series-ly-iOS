//
//  ManejadorServicioWebSeriesly.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 26/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthToken,UserToken,UserInfo,Links,FullInfo;
@interface ManejadorServicioWebSeriesly : NSObject

+(ManejadorServicioWebSeriesly *) getInstance;

-(AuthToken *) checkAuthToken: (AuthToken *) authToken;

-(void) logoutWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(AuthToken *) getAuthToken;
-(UserToken *) getUserTokenWithAuthToken: (AuthToken *) authToken UserName: (NSString *) userName Password: (NSString *) password Remember: (NSString *) remember;
-(UserInfo *) getUserInfoWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;

/*-(NSMutableArray *) getUserPendingSeriesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserPendingTvShowsWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserPendingMoviesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserPendingDocumentariesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;*/

-(NSMutableDictionary *) getUserPendingInfoWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;

-(NSMutableArray *) getUserFollowingSeriesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserFollowingTvShowsWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserFollowingMoviesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserFollowingDocumentariesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;


-(Links *) getLinksWithAuthToken: (AuthToken *) authToken Idm: (NSString *) idm MediaType: (NSString *) mediaType;
-(FullInfo *) getMediaFullInfoWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken Idm: (NSString *) idm MediaType: (NSString *) mediaType;

@end
