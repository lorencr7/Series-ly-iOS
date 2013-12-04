//
//  GeolocationManager.m
//  GeolocalizationTest
//
//  Created by Laboratorio Ingeniería Software on 03/12/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import "GeolocationManager.h"

// Variable estatica que nos sirve para la implementacion del patron solitario
static GeolocationManager *instance;

/**
 @Class GeolocationManager
 @Description mediante esta clase podemos obtener nuestra ubicacion actual
 @Method getInstance
 @Method refreshLocation
 @Method refreshLocationWithManager
 @Method locationManager didUpdateLocations
 @Method locationManager didFailWithError
 **/
@implementation GeolocationManager

/**
 @Method getInstance
 @Description metodo que nos devuelve la unica instancia activa de la clase 
 @Return GeolocationManager
 **/
+ (GeolocationManager *) getInstance {
    if (instance == nil) {
        instance = [[GeolocationManager alloc] init];
    }
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10.0f;
        self.maxTries = 7;
        self.numberOfTries = 0;
    }
    return self;
}

/**
 @Method refreshLocation
 @Description inicia el valor del property locationManager y le solicita que empiece a ubicarnos
 @Return void
 **/
-(void) refreshLocation {
    
    //NSLog(@"se llama a refresh location");
    self.numberOfTries = 0;
    [self.locationManager startUpdatingLocation];
}

/**
 @Method refreshLocationWithManager
 @Description 
 @Param (CLLocationManager *) manager
 @Return void
 **/
-(void) refreshLocationWithManager:(CLLocationManager *) manager  {
    //NSLog(@"aqui?");
    self.locationManager = manager;
    [self.locationManager startUpdatingLocation];
}

/**
 @Method locationManager
 @Description este metodo se ejecuta cuando se ha encontrado nuestra ubicacion
 @Param (CLLocationManager *) manager
 @Param (NSArray *)locations
 @Return void
 **/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if ([locations count] > 0) {
        //NSLog(@"locations = %d",locations.count);
        CLLocation *location = [locations objectAtIndex:0];
        if (self.numberOfTries >= self.maxTries) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"currentLocation" object:location];
            [manager stopUpdatingLocation];
            return;
        }
        //NSLog(@"%.2f,%.2f",location.horizontalAccuracy,location.verticalAccuracy);
        if (location.horizontalAccuracy < 200 && location.verticalAccuracy < 200) {
            //NSLog(@"%.8f,%.8f",location.coordinate.latitude,location.coordinate.longitude);
            //NSLog(@"%.2f,%.2f", location.horizontalAccuracy,location.horizontalAccuracy);
           [[NSNotificationCenter defaultCenter] postNotificationName:@"currentLocation" object:location];
            [manager stopUpdatingLocation];
            self.numberOfTries++;
        }
        
        
        
    }
}

/**
 @Method locationManager
 @Description este metodo se ejecuta cuando ha habiado un error al localizarnos
 @Param (CLLocationManager *) manager
 @Param (NSError *)error
 @Return void
 **/
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    //NSLog(@"error refreshed!!! %d",error.code);
    if (error.code != 0) {
        NSString* failureMessage = NSLocalizedString(@"LocationFailureError", nil);
        UIAlertView* failureAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                               message:failureMessage
                                                              delegate:nil
                                                     cancelButtonTitle:NSLocalizedString(@"ProblemLoginAction", nil)
                                                     otherButtonTitles:nil];
        [failureAlert show];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"errorLocation" object:error];
}

@end
