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

@implementation ManejadorServicioWebSeriesLy

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
    NSString * fullUrl = [NSString stringWithFormat:@"%@/%@?auth_token=%@&user_token=%@",BASESTRING,path,@"",@""];
    //NSString * fullUrl = [NSString stringWithFormat:@"%@/%@?api_key=%@&token=%@",BASESTRING,path,APIKEY,@"SuMs3xq3jNvzxcTS3rYQ"];
    
    return fullUrl;
}

-(AuthToken *) checkAuthToken: (AuthToken *) authToken {
    NSDate * fecha = [NSDate date];
    long currentDate =  [fecha timeIntervalSince1970];
    long expireDate = authToken.authExpiresDate;
    //NSLog(@"%d",expireDate - currentDate);
    if (currentDate > expireDate) {
        NSLog(@"authToken invalido, pidiendo nuevo authToken");
        UserCredentials * userCredentials = [UserCredentials getInstance];
        AuthToken * newAuthToken = [self getAuthTokenWithRequest:nil ProgressView:nil];
        userCredentials.authToken = newAuthToken;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:newAuthToken.authToken forKey:@"authToken"];
        /*ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
        [manejadorBaseDeDatosBackup borrarUserCredentials];
        [manejadorBaseDeDatosBackup guardarUserCredentials:userCredentials];*/
        return newAuthToken;
        
    } else {
        //NSLog(@"authToken valido");
    }
    return authToken;
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
        //NSLog(@"%@",response);
        return [[AuthToken alloc] initWithDictionary:response];
    }
}

-(UserToken *) getUserTokenWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserName: (NSString *) userName Password: (NSString *) password Remember: (NSString *) remember {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/user_token?auth_token=%@&username=%@&password=%@&remember=%@&user_agent=HTTP_USER_AGENT&response=json",newAuthToken.authToken,userName,password,remember];
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

@end
