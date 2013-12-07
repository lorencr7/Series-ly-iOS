//
//  ManejadorServicioWebSeriesLy.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 04/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "ManejadorServicioWebSeriesLy.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "AuthToken.h"
#import "UserCredentials.h"
#import "UserToken.h"
#import "User.h"
#import "AppDelegate.h"

static ManejadorServicioWebSeriesLy * instance;

@implementation ManejadorServicioWebSeriesLy

+(ManejadorServicioWebSeriesLy *) getInstance {
    if (instance == nil) {
        instance = [[ManejadorServicioWebSeriesLy alloc] init];
    }
    
    return instance;
}

-(ASIHTTPRequest *) configureRequest:(ASIHTTPRequest *) request URL: (NSString *) urlString ProgressView: (UIProgressView *) progressView {
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES];
    NSURL *url = [NSURL URLWithString:urlString];
    if (!request) {
        request = [ASIHTTPRequest requestWithURL:url];
    } else {
        [request setURL:url];
    }
    if (progressView) {
        [request setDownloadProgressDelegate:progressView];
        request.showAccurateProgress = YES;
    }
    return request;
}

-(NSString *) configureUrlWithPath: (NSString *) path {
    UserCredentials * credentials = [UserCredentials getInstance];
    NSString * fullUrl = [NSString stringWithFormat:@"%@/%@?auth_token=%@&user_token=%@",BASESTRING,path,credentials.authToken.authToken,credentials.userToken.userToken];
    return fullUrl;
}

-(ASIHTTPRequest *) setCacheToRequest:(ASIHTTPRequest *) request {
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    return request;
}

-(ASIHTTPRequest *) setGETHeadersToRequest:(ASIHTTPRequest *) request {
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    return request;
}

-(void) checkAuthToken {
    UserCredentials * userCredentials = [UserCredentials getInstance];
    AuthToken * authToken = userCredentials.authToken;
    
    NSDate * fecha = [NSDate date];
    long currentDate =  [fecha timeIntervalSince1970];
    long expireDate = authToken.authExpiresDate.longValue;
    currentDate += 1000;
    //NSLog(@"%ld,%ld",authToken.authExpiresDate.longValue, currentDate);
    if (currentDate > expireDate) {
        NSLog(@"authToken invalido, pidiendo nuevo authToken");
        
        
        AuthToken * newAuthToken = [self getAuthTokenWithRequest:nil ProgressView:nil];
        userCredentials.authToken = newAuthToken;
        
        
        AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate saveData];
        /*NSData *objectEncoded = [NSKeyedArchiver archivedDataWithRootObject:newAuthToken];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:objectEncoded forKey:@"authToken"];*/
        
        //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //[defaults setObject:newAuthToken.authToken forKey:@"authToken"];
        /*ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
        [manejadorBaseDeDatosBackup borrarUserCredentials];
        [manejadorBaseDeDatosBackup guardarUserCredentials:userCredentials];*/
        //return newAuthToken;
        
    } else {
        //NSLog(@"authToken valido");
    }
    //return authToken;
}

-(AuthToken *) getAuthTokenWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView {
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/auth_token/?id_api=%@&secret=%@&response=json",APPID,APPSECRET];
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    //NSLog(@"%@",urlString);
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",response);
        return [[AuthToken alloc] initWithDictionary:response];
    }
}

-(UserToken *) getUserTokenWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserName: (NSString *) userName Password: (NSString *) password Remember: (NSString *) remember {
    
    [self checkAuthToken];
    
    UserCredentials * userCredentials = [UserCredentials getInstance];
    
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/user_token?auth_token=%@&username=%@&password=%@&remember=%@&user_agent=HTTP_USER_AGENT&response=json",userCredentials.authToken.authToken,userName,password,remember];
    //NSLog(@"%@",urlString);
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        return [[UserToken alloc] initWithDictionary:response];
    }
    
}

-(User *) getUserInfoWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView {
    
    [self checkAuthToken];
    //NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSString * urlString = [self configureUrlWithPath:@"user"];
    
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    request = [self setGETHeadersToRequest:request];
    request = [self setCacheToRequest:request];
    
    [request startSynchronous];
    
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary * userDictionary = response[@"result"];
        //NSLog(@"%@",response);
        return [[User alloc] initWithDictionary:userDictionary];
    }
    
}

@end
