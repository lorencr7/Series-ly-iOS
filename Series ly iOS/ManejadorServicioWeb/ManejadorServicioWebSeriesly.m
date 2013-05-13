//
//  ManejadorServicioWebSeriesly.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 26/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "ManejadorServicioWebSeriesly.h"
#import "AuthToken.h"
#import "UserToken.h"
#import "UserCredentials.h"
//#import "PerfilViewController.h"
#import "UserInfo.h"
#import "ManejadorBaseDeDatosBackup.h"
#import "MediaElementUserPending.h"
#import "MediaElementUser.h"
#import "Links.h"
#import "FullInfo.h"
#import "ASIHTTPRequest.h"

static ManejadorServicioWebSeriesly * instance;

static NSString * appId = @"1040";
static NSString * appSecret = @"n6RDtC2qVTAfDPyWUppu";

@implementation ManejadorServicioWebSeriesly

+(ManejadorServicioWebSeriesly *) getInstance {
    if (instance == nil) {
        instance = [[ManejadorServicioWebSeriesly alloc] init];
    }
    
    return instance;
}

-(AuthToken *) checkAuthToken: (AuthToken *) authToken {
    NSDate * fecha = [NSDate date];
    long currentDate =  [fecha timeIntervalSince1970];
    long expireDate = authToken.authExpiresDate ;
    //NSLog(@"%d",expireDate - currentDate);
    if (currentDate > expireDate) {
        NSLog(@"authToken invalido, pidiendo nuevo authToken");
        UserCredentials * userCredentials = [UserCredentials getInstance];
        AuthToken * newAuthToken = [self getAuthTokenWithRequest:nil ProgressView:nil];
        userCredentials.authToken = newAuthToken;
        ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
        [manejadorBaseDeDatosBackup borrarUserCredentials];
        [manejadorBaseDeDatosBackup guardarUserCredentials:userCredentials];
        return newAuthToken;
        
    } else {
        //NSLog(@"authToken valido");
    }
    return authToken;
    
}

-(NSData *) performRequestWithURL: (NSString *) url Error: (NSError *) error{
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setTimeoutInterval:10.0];
    NSHTTPURLResponse* urlResponse = nil;
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
}

-(void) logoutWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/logout?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        NSLog(@"%@",error);
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",response);
    }
}

-(ASIHTTPRequest *) configureRequest:(ASIHTTPRequest *) request URL: (NSString *) urlString ProgressView: (UIProgressView *) progressView {
    NSURL *url = [NSURL URLWithString:urlString];
    if (!request) {
        request = [ASIHTTPRequest requestWithURL:url];
    } else {
        [request setURL:url];
    }
    if (progressView) {
        [request setDownloadProgressDelegate:progressView];
    }
    return request;
    
}

-(AuthToken *) getAuthTokenWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView {
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/auth_token/?id_api=%@&secret=%@&response=json",appId,appSecret];
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

-(UserInfo *) getUserInfoWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        return [[UserInfo alloc] initWithDictionary:response];
    }
    
}
-(NSMutableDictionary *) getUserPendingInfoWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/pending?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    //NSLog(@"%@",urlString);
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"series"];
        NSArray * tvShowsArray = [response objectForKey:@"tvshows"];
        NSArray * moviesArray = [response objectForKey:@"movies"];
        NSArray * documentariesArray = [response objectForKey:@"documentaries"];
        NSMutableArray * arrayOfSeries = [NSMutableArray array];
        NSMutableArray * arrayOfTvShows = [NSMutableArray array];
        NSMutableArray * arrayOfMovies = [NSMutableArray array];
        NSMutableArray * arrayOfDocumentaries = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfSeries addObject:[[MediaElementUserPending alloc] initWithDictionary:serieDictionary]];
        }
        for (NSDictionary * tvShowDictionary in tvShowsArray) {
            [arrayOfTvShows addObject:[[MediaElementUserPending alloc] initWithDictionary:tvShowDictionary]];
        }
        for (NSDictionary * movieDictionary in moviesArray) {
            [arrayOfMovies addObject:[[MediaElementUserPending alloc] initWithDictionary:movieDictionary]];
        }
        for (NSDictionary * documentaryDictionary in documentariesArray) {
            [arrayOfDocumentaries addObject:[[MediaElementUserPending alloc] initWithDictionary:documentaryDictionary]];
        }
        NSMutableDictionary * infoDictionary = [[NSMutableDictionary alloc] init];
        [infoDictionary setObject:arrayOfSeries forKey:@"series"];
        [infoDictionary setObject:arrayOfTvShows forKey:@"tvshows"];
        [infoDictionary setObject:arrayOfMovies forKey:@"movies"];
        [infoDictionary setObject:arrayOfDocumentaries forKey:@"documentaries"];
        return infoDictionary;
    }
    
}

-(NSMutableArray *) getUserFollowingSeriesWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/series?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"series"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[MediaElementUser alloc] initWithDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
    
}

-(NSMutableArray *) getUserFollowingTvShowsWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/tvshows?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"tvshows"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[MediaElementUser alloc] initWithDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
    
}

-(NSMutableArray *) getUserFollowingMoviesWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/movies?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"movies"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[MediaElementUser alloc] initWithDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
    
}

-(NSMutableArray *) getUserFollowingDocumentariesWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/documentaries?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"documentaries"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[MediaElementUser alloc] initWithDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
    
}

-(Links *) getLinksWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken Idm: (NSString *) idm MediaType: (NSString *) mediaType {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
     NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/media/episode/links?auth_token=%@&idm=%@&mediaType=%@",newAuthToken.authToken,idm,mediaType];
    
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        return [[Links alloc] initWithDictionary:response];
    }
    
}


-(FullInfo *) getMediaFullInfoWithRequest: (ASIHTTPRequest *) request ProgressView: (UIProgressView *) progressView AuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken Idm: (NSString *) idm MediaType: (NSString *) mediaType {
    
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/media/full_info/?idm=%@&mediaType=%@&auth_token=%@&user_token=%@",idm ,mediaType ,newAuthToken.authToken,userToken.userToken];
    
    request = [self configureRequest:request URL:urlString ProgressView:progressView];
    [request startSynchronous];
    NSError *error = [request error];
    if (error) {
        return nil;
    } else {
        NSData *responseData = [request responseData];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        return [[FullInfo alloc] initWithDictionary:response];
    }
    
}



@end
