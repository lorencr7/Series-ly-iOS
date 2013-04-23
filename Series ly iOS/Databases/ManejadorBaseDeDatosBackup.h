//
//  ManejadorBaseDeDatosBackup.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import  <Foundation/Foundation.h>

@class User,UserCredentials;
@interface ManejadorBaseDeDatosBackup : NSObject

+ (ManejadorBaseDeDatosBackup *) getInstance;
+ (NSString *) getDataBaseName;

/*-(User *) cargarInformacionUsuario;
-(void) guardarInformacionUsuario:(User *) usuario;
-(void) borrarInformacionUsuario;*/

-(UserCredentials *) cargarUserCredentials;
-(void) guardarUserCredentials: (UserCredentials *) userCredentials;
-(void) borrarUserCredentials;

@end
