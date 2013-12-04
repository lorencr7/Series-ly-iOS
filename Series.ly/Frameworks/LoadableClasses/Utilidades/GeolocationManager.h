//
//  GeolocationManager.h
//  GeolocalizationTest
//
//  Created by Laboratorio Ingeniería Software on 03/12/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 @Class GeolocationManager
 @Description mediante esta clase podemos obtener nuestra ubicacion actual
 @Property locationManager - declaramos el location manager sobre el que interactuaremos
 @Method getInstance 
 @Method refreshLocation
 **/
@interface GeolocationManager : NSObject <CLLocationManagerDelegate>

@property (assign, atomic) int numberOfTries;
@property (assign, nonatomic) int maxTries;
@property (strong, nonatomic) CLLocationManager *locationManager;

+ (GeolocationManager *) getInstance;
-(void) refreshLocation;


@end
