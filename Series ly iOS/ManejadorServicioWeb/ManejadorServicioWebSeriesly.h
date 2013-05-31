//
//  ManejadorServicioWebSeriesly.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 26/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthToken,UserToken,UserInfo,Links,FullInfo, ASIHTTPRequest;
@interface ManejadorServicioWebSeriesly : NSObject

+(ManejadorServicioWebSeriesly *) getInstance;

-(AuthToken *) checkAuthToken: (AuthToken *) authToken;

-(void) logoutWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;


-(AuthToken *) getAuthTokenWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView;

-(UserToken *) getUserTokenWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserName: (NSString *) userName Password: (NSString *) password Remember: (NSString *) remember;
-(UserInfo *) getUserInfoWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;

-(NSMutableDictionary *) getUserPendingInfoWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;

-(NSMutableArray *) getUserFollowingSeriesWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserFollowingTvShowsWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserFollowingMoviesWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;
-(NSMutableArray *) getUserFollowingDocumentariesWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken;


-(Links *) getLinksWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken Idm: (NSString *) idm MediaType: (NSString *) mediaType;
-(FullInfo *) getMediaFullInfoWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken Idm: (NSString *) idm MediaType: (NSString *) mediaType;

-(NSMutableArray *) getSearchResultsWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken Query: (NSString *) query;


@end
