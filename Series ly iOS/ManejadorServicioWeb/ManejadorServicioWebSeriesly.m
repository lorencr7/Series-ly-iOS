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
#import "PerfilViewController.h"
#import "UserInfo.h"
#import "ManejadorBaseDeDatosBackup.h"
#import "MediaElementUserPending.h"
#import "MediaElementUser.h"
#import "Links.h"
#import "FullInfo.h"

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
        UserCredentials * userCredentials = [PerfilViewController getUserCredentials];
        AuthToken * newAuthToken = [self getAuthToken];
        UserToken * userToken = userCredentials.userToken;
        userCredentials = [[UserCredentials alloc] initWithAuthToken:newAuthToken UserToken:userToken];
        [PerfilViewController setUserCredentials:userCredentials];
        ManejadorBaseDeDatosBackup * manejadorBaseDeDatosBackup = [ManejadorBaseDeDatosBackup getInstance];
        [manejadorBaseDeDatosBackup borrarUserCredentials];
        [manejadorBaseDeDatosBackup guardarUserCredentials:[PerfilViewController getUserCredentials]];
        return newAuthToken;

    } else {
        //NSLog(@"authToken valido");
    }
    return authToken;
    
}

-(NSData *) performRequestWithURL: (NSString *) url Error: (NSError *) error{
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setTimeoutInterval:5.0];
    NSHTTPURLResponse* urlResponse = nil;
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
}

-(void) logoutWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/logout?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return;
    }
    if (error) {
        NSLog(@"Error logout");
    } else {
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",response);
    }
}

-(AuthToken *) getAuthToken {
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/auth_token/?id_api=%@&secret=%@&response=json",appId,appSecret];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto getAuthToken");
        return nil;
    }
    if (error) {
        NSLog(@"Error getAuthToken %@",error);
        return nil;
    } else {
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",response);
        //return [[TraductorClases getInstance] getAuthTokenFromDictionary:response];
        return [[AuthToken alloc] initWithDictionary:response];
    }
}

-(UserToken *) getUserTokenWithAuthToken: (AuthToken *) authToken UserName: (NSString *) userName Password: (NSString *) password Remember: (NSString *) remember  {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/user_token?auth_token=%@&username=%@&password=%@&remember=%@&user_agent=HTTP_USER_AGENT&response=json",newAuthToken.authToken,userName,password,remember];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto getUserTokenWithAuthToken");
        return nil;
    }
    if (error) {
        NSLog(@"Error getUserTokenWithAuthToken %@",error);
        return nil;
    } else {
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //return [[TraductorClases getInstance] getUserTokenFromDictionary:response];
        return [[UserToken alloc] initWithDictionary:response];
    }
}

-(UserInfo *) getUserInfoWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto getUserInfoWithAuthToken");
        return nil;
    }
    if (error) {
        NSLog(@"Error getUserInfoWithAuthToken %@",error);
        return nil;
    } else {
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        //return [[TraductorClases getInstance] getUserInfoFromDictionary:response];
        return [[UserInfo alloc] initWithDictionary:response];
    }
}


-(NSMutableDictionary *) getUserPendingInfoWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/pending?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    //NSLog(@"%@",urlString);
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto getUserPendingInfoWithAuthToken");
        return nil;
    }
    if (error) {
        NSLog(@"Error getUserPendingInfoWithAuthToken %@",error);
        return nil;
    } else {
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
            //[arrayOfSeries addObject:[traductorClases getMediaElementUserPendingFromDictionary:serieDictionary]];
            [arrayOfSeries addObject:[[MediaElementUserPending alloc] initWithDictionary:serieDictionary]];
        }
        for (NSDictionary * tvShowDictionary in tvShowsArray) {
            //[arrayOfTvShows addObject:[traductorClases getMediaElementUserPendingFromDictionary:tvShowDictionary]];
            [arrayOfTvShows addObject:[[MediaElementUserPending alloc] initWithDictionary:tvShowDictionary]];
        }
        for (NSDictionary * movieDictionary in moviesArray) {
            //[arrayOfMovies addObject:[traductorClases getMediaElementUserPendingFromDictionary:movieDictionary]];
            [arrayOfMovies addObject:[[MediaElementUserPending alloc] initWithDictionary:movieDictionary]];
        }
        for (NSDictionary * documentaryDictionary in documentariesArray) {
            //[arrayOfDocumentaries addObject:[traductorClases getMediaElementUserPendingFromDictionary:documentaryDictionary]];
            [arrayOfDocumentaries addObject:[[MediaElementUserPending alloc] initWithDictionary:documentaryDictionary]];
        }
        /*NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[TraductorClases getInstance] getMediaElementUserPendingFromDictionary:serieDictionary]];
        }*/
        NSMutableDictionary * infoDictionary = [[NSMutableDictionary alloc] init];
        [infoDictionary setObject:arrayOfSeries forKey:@"series"];
        [infoDictionary setObject:arrayOfTvShows forKey:@"tvshows"];
        [infoDictionary setObject:arrayOfMovies forKey:@"movies"];
        [infoDictionary setObject:arrayOfDocumentaries forKey:@"documentaries"];
        return infoDictionary;
    }
}
/*
-(NSMutableArray *) getUserPendingSeriesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/pending/series?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo la info del usuario");
        return nil;
    } else {
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"series"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[TraductorClases getInstance] getMediaElementUserPendingFromDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
}

-(NSMutableArray *) getUserPendingTvShowsWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/pending/tvshows?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo la info del usuario");
        return nil;
    } else {
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"tvshows"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[TraductorClases getInstance] getMediaElementUserPendingFromDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
}

-(NSMutableArray *) getUserPendingMoviesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/pending/movies?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo la info del usuario");
        return nil;
    } else {
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"movies"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[TraductorClases getInstance] getMediaElementUserPendingFromDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
}

-(NSMutableArray *) getUserPendingDocumentariesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/pending/documentaries?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo la info del usuario");
        return nil;
    } else {
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"documentaries"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            [arrayOfElements addObject:[[TraductorClases getInstance] getMediaElementUserPendingFromDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
}*/

-(NSMutableArray *) getUserFollowingSeriesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/series?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto getUserFollowingSeriesWithAuthToken");
        return nil;
    }
    if (error) {
        NSLog(@"Error getUserFollowingSeriesWithAuthToken %@",error);
        return nil;
    } else {
        //TraductorClases * traductorClases = [TraductorClases getInstance];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"series"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            //[arrayOfElements addObject:[traductorClases getMediaElementUserFromDictionary:serieDictionary]];
            [arrayOfElements addObject:[[MediaElementUser alloc] initWithDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
}

-(NSMutableArray *) getUserFollowingTvShowsWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/tvshows?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo la info del usuario");
        return nil;
    } else {
        //TraductorClases * traductorClases = [TraductorClases getInstance];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"tvshows"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            //[arrayOfElements addObject:[traductorClases getMediaElementUserFromDictionary:serieDictionary]];
            [arrayOfElements addObject:[[MediaElementUser alloc] initWithDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
}

-(NSMutableArray *) getUserFollowingMoviesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/movies?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    //NSLog(@"%@",urlString);
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo la info del usuario");
        return nil;
    } else {
        //TraductorClases * traductorClases = [TraductorClases getInstance];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"movies"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            //[arrayOfElements addObject:[traductorClases getMediaElementUserFromDictionary:serieDictionary]];
            [arrayOfElements addObject:[[MediaElementUser alloc] initWithDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
}

-(NSMutableArray *) getUserFollowingDocumentariesWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/user/media/documentaries?auth_token=%@&user_token=%@",newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo la info del usuario");
        return nil;
    } else {
        //TraductorClases * traductorClases = [TraductorClases getInstance];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        NSArray * seriesArray = [response objectForKey:@"documentaries"];
        NSMutableArray * arrayOfElements = [NSMutableArray array];
        for (NSDictionary * serieDictionary in seriesArray) {
            //[arrayOfElements addObject:[traductorClases getMediaElementUserFromDictionary:serieDictionary]];
            [arrayOfElements addObject:[[MediaElementUser alloc] initWithDictionary:serieDictionary]];
        }
        return arrayOfElements;
    }
}

-(Links *) getLinksWithAuthToken: (AuthToken *) authToken Idm: (NSString *) idm MediaType: (NSString *) mediaType {
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/media/episode/links?auth_token=%@&idm=%@&mediaType=%@",newAuthToken.authToken,idm,mediaType];
    NSLog(@"%@",urlString);
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo los links");
        return nil;
    } else {
        //TraductorClases * traductorClases = [TraductorClases getInstance];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        //return [traductorClases getLinksFromDictionary:response];
        return [[Links alloc] initWithDictionary:response];
    }
    
}

-(FullInfo *) getMediaFullInfoWithAuthToken: (AuthToken *) authToken UserToken: (UserToken *) userToken Idm: (NSString *) idm MediaType: (NSString *) mediaType{
    AuthToken * newAuthToken = [self checkAuthToken:authToken];
    NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/media/full_info/?idm=%@&mediaType=%@&auth_token=%@&user_token=%@",idm ,mediaType ,newAuthToken.authToken,userToken.userToken];
    NSError *error;
    NSData *responseData = [self performRequestWithURL:urlString Error:error];
    if (!responseData) {
        NSLog(@"No hay data devuelto");
        return nil;
    }
    if (error) {
        NSLog(@"Error cogiendo los links");
        return nil;
    } else {
        //TraductorClases * traductorClases = [TraductorClases getInstance];
        NSDictionary * response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",response);
        //return [traductorClases getFullInfoFromDictionary:response];
        return [[FullInfo alloc] initWithDictionary:response];
    }
}


@end
