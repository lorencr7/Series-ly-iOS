//
//  ManejadorServicioWebSeriesLy.h
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest,AuthToken,UserToken,User;
@interface ManejadorServicioWebSeriesLy : NSObject

+(ManejadorServicioWebSeriesLy *) getInstance;

//GET
-(AuthToken *) getAuthTokenWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView;
-(UserToken *) getUserTokenWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserName: (NSString *) userName Password: (NSString *) password Remember: (NSString *) remember;
-(User *) getUserInfoWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView;

@end
