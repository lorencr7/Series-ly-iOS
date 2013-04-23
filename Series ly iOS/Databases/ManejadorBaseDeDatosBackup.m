//
//  ManejadorBaseDeDatosBackup.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//
#import "ManejadorBaseDeDatosBackup.h"
#import <sqlite3.h>
#import "User.h"
#import "UserCountry.h"
#import "UserData.h"
#import "UserExtInfo.h"
#import "UserImgUser.h"
#import "UserCredentials.h"
#import "AuthToken.h"
#import "UserToken.h"
#import "UserInfo.h"

static ManejadorBaseDeDatosBackup * instance;
static NSString * databaseName = @"backup.sqlite";

@implementation ManejadorBaseDeDatosBackup


/**
 @Method getInstance
 @Description Devuelve la instancia de la clase ManejadorBaseDeDatosBackup
 @Return La instancia de ManejadorBaseDeDatosBackup
 **/
+ (ManejadorBaseDeDatosBackup *) getInstance {
    if (instance == nil) {
        instance = [[ManejadorBaseDeDatosBackup alloc] init];
    }
    return instance;
}

/**
 @Method getDataBaseName
 @Description Devuelve el nombre de la base de datos de backup
 @Return El nombre de la base de datos de backup
 **/
+ (NSString *) getDataBaseName {
    return databaseName;
}

/**
 @Method createEditableCopyOfDatabaseIfNeeded
 @Description Crea el fichero de la base de datos en la carpeta documents si no existía antes
 @Return void
 **/
- (void) createEditableCopyOfDatabaseIfNeeded {
    BOOL success;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError * error;
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * writableDBPath = [documentsDirectory stringByAppendingPathComponent:databaseName];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) {
        return;
    }
    NSString * defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database with message '%@'.", [error localizedDescription]);
    }
}

/*-(User *) cargarInformacionUsuario {
    BOOL hayUser = NO;
    const char * uid;
	const char * cp;
	const char * nom;
	const char * cognoms;
	const char * dataNaixement;
	const char * sexe;
	const char * veureNom;
	const char * veureEmail;
	const char * lang;
	const char * userDescription;
	const char * profesion;
	const char * uidUserData;
	const char * uidCodi;
	const char * nick;
	const char * email;
	const char * dataAlta;
	const char * punts;
	const char * userAgentHash;
	const char * big;
	const char * small;
	const char * iso;
	const char * name;
	const char * error;
    
    NSString * uidTexto;
	NSString * cpTexto;
	NSString * nomTexto;
	NSString * cognomsTexto;
	NSString * dataNaixementTexto;
	NSString * sexeTexto;
	NSString * veureNomTexto;
	NSString * veureEmailTexto;
	NSString * langTexto;
	NSString * userDescriptionTexto;
	NSString * profesionTexto;
	NSString * uidUserDataTexto;
	NSString * uidCodiTexto;
	NSString * nickTexto;
	NSString * emailTexto;
	NSString * dataAltaTexto;
	NSString * puntsTexto;
	NSString * userAgentHashTexto;
	NSString * bigTexto;
	NSString * smallTexto;
	NSString * isoTexto;
	NSString * nameTexto;
	NSString * errorTexto;
    
    sqlite3 * database;
    sqlite3_stmt * stmt;
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:databaseName];
    const char * dbPath = [path UTF8String];
    const char * sqlQuery;
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {//abrimos la base de datos
        sqlQuery = "select * from Usuario";
        if (sqlite3_prepare_v2(database, sqlQuery, -1, &stmt, NULL) == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                hayUser = YES;
                
                uid = (const char *)sqlite3_column_text(stmt, 0);
                cp = (const char *)sqlite3_column_text(stmt, 1);
                nom = (const char *)sqlite3_column_text(stmt, 2);
                cognoms = (const char *)sqlite3_column_text(stmt, 3);
                dataNaixement = (const char *)sqlite3_column_text(stmt, 4);
                sexe = (const char *)sqlite3_column_text(stmt, 5);
                veureNom = (const char *)sqlite3_column_text(stmt, 6);
                veureEmail = (const char *)sqlite3_column_text(stmt, 7);
                lang = (const char *)sqlite3_column_text(stmt, 8);
                userDescription = (const char *)sqlite3_column_text(stmt, 9);
                profesion = (const char *)sqlite3_column_text(stmt, 10);
                uidUserData = (const char *)sqlite3_column_text(stmt, 11);
                uidCodi = (const char *)sqlite3_column_text(stmt, 12);
                nick = (const char *)sqlite3_column_text(stmt, 13);
                email = (const char *)sqlite3_column_text(stmt, 14);
                dataAlta = (const char *)sqlite3_column_text(stmt, 15);
                punts = (const char *)sqlite3_column_text(stmt, 16);
                userAgentHash = (const char *)sqlite3_column_text(stmt, 17);
                big = (const char *)sqlite3_column_text(stmt, 18);
                small = (const char *)sqlite3_column_text(stmt, 19);
                iso = (const char *)sqlite3_column_text(stmt, 20);
                name = (const char *)sqlite3_column_text(stmt, 21);
                error = (const char *)sqlite3_column_text(stmt, 22);
                
                if (uid != NULL) {
                    uidTexto = [NSString stringWithUTF8String:(const char*)uid];
                }
                
                if (cp != NULL) {
                    cpTexto = [NSString stringWithUTF8String:(const char*)cp];
                }
                
                if (nom != NULL) {
                    nomTexto = [NSString stringWithUTF8String:(const char*)nom];
                }
                
                if (cognoms != NULL) {
                    cognomsTexto = [NSString stringWithUTF8String:(const char*)cognoms];
                }
                
                if (dataNaixement != NULL) {
                    dataNaixementTexto = [NSString stringWithUTF8String:(const char*)dataNaixement];
                }
                
                if (sexe != NULL) {
                    sexeTexto = [NSString stringWithUTF8String:(const char*)sexe];
                }
                
                if (veureNom != NULL) {
                    veureNomTexto = [NSString stringWithUTF8String:(const char*)veureNom];
                }
                
                if (veureEmail != NULL) {
                    veureEmailTexto = [NSString stringWithUTF8String:(const char*)veureEmail];
                }
                
                if (lang != NULL) {
                    langTexto = [NSString stringWithUTF8String:(const char*)lang];
                }
                
                if (userDescription != NULL) {
                    userDescriptionTexto = [NSString stringWithUTF8String:(const char*)userDescription];
                }
                
                if (profesion != NULL) {
                    profesionTexto = [NSString stringWithUTF8String:(const char*)profesion];
                }
                
                if (uidUserData != NULL) {
                    uidUserDataTexto = [NSString stringWithUTF8String:(const char*)uidUserData];
                }
                
                if (uidCodi != NULL) {
                    uidCodiTexto = [NSString stringWithUTF8String:(const char*)uidCodi];
                }
                
                if (nick != NULL) {
                    nickTexto = [NSString stringWithUTF8String:(const char*)nick];
                }
                
                if (email != NULL) {
                    emailTexto = [NSString stringWithUTF8String:(const char*)email];
                }
                
                if (dataAlta != NULL) {
                    dataAltaTexto = [NSString stringWithUTF8String:(const char*)dataAlta];
                }
                
                if (punts != NULL) {
                    puntsTexto = [NSString stringWithUTF8String:(const char*)punts];
                }
                
                if (userAgentHash != NULL) {
                    userAgentHashTexto = [NSString stringWithUTF8String:(const char*)userAgentHash];
                }
                
                if (big != NULL) {
                    bigTexto = [NSString stringWithUTF8String:(const char*)big];
                }
                
                if (small != NULL) {
                    smallTexto = [NSString stringWithUTF8String:(const char*)small];
                }
                
                if (iso != NULL) {
                    isoTexto = [NSString stringWithUTF8String:(const char*)iso];
                }
                
                if (name != NULL) {
                    nameTexto = [NSString stringWithUTF8String:(const char*)name];
                }
                
                if (error != NULL) {
                    errorTexto = [NSString stringWithUTF8String:(const char*)error];
                }
                
                
                sqlite3_finalize(stmt);
            }
        } else {//no se preparo bien la query
            ////NSLog(@"No se preparo bien la query de InsertarMensaje");
        }
    }
    if (hayUser) {
        UserImgUser * imgUser = [[UserImgUser alloc] initWithBig:bigTexto Small:smallTexto];
        UserCountry * userCountry = [[UserCountry alloc] initWithIso:isoTexto Name:nameTexto];
        UserData * userData = [[UserData alloc] initWithUid:uidUserDataTexto UidCodi:uidCodiTexto Nick:nickTexto Email:emailTexto DataAlta:dataAltaTexto Punts:puntsTexto UserAgentHash:userAgentHashTexto ImgUser:imgUser Country:userCountry];
        UserExtInfo * exiInfo = [[UserExtInfo alloc] initWithCp:cpTexto Nom:nomTexto Cognoms:cognomsTexto DataNaixement:dataNaixementTexto Sexe:sexeTexto VeureNom:veureNomTexto VeureEmail:veureEmailTexto Lang:langTexto UserDescription:userDescriptionTexto Profesion:profesionTexto];
        User * user = [[User alloc] init];
        UserInfo * userInfo = [[UserInfo alloc] initWithUid:uidTexto ExiInfo:exiInfo UserData:userData Error:errorTexto];
        user.userInfo = userInfo;
        return user;
    } else {
        return nil;
    }
}

-(void) guardarInformacionUsuario:(User *) usuario {
    [self createEditableCopyOfDatabaseIfNeeded];
    sqlite3 * database;
    sqlite3_stmt * stmt;
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:databaseName];
    const char * dbPath = [path UTF8String];
    const char * sqlQuery;
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {//abrimos la base de datos
        //insertamos en Mensaje
        //Insertar fecha,estado,texto
        sqlQuery = "insert into Usuario (uid,cp,nom,cognoms,dataNaixement,sexe,veureNom,veureEmail,lang,userDescription,profesion,uidUserData,uidCodi,nick,email,dataAlta,punts,userAgentHash,big,small,iso,name,error) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        
        if (sqlite3_prepare_v2(database, sqlQuery, -1, &stmt, NULL) == SQLITE_OK) {
            
            sqlite3_bind_text(stmt, 1, [usuario.userInfo.uid UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 2, [usuario.userInfo.extInfo.cp UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 3, [usuario.userInfo.extInfo.nom  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 4, [usuario.userInfo.extInfo.cognoms UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 5, [usuario.userInfo.extInfo.dataNaixement  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 6, [usuario.userInfo.extInfo.sexe UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 7, [usuario.userInfo.extInfo.veureNom  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 8, [usuario.userInfo.extInfo.veureEmail UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 9, [usuario.userInfo.extInfo.lang  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 10, [usuario.userInfo.extInfo.userDescription UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 11, [usuario.userInfo.extInfo.profesion  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 12, [usuario.userInfo.userData.uid  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 13, [usuario.userInfo.userData.uidCodi  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 14, [usuario.userInfo.userData.nick  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 15, [usuario.userInfo.userData.email  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 16, [usuario.userInfo.userData.dataAlta  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 17, [usuario.userInfo.userData.punts  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 18, [usuario.userInfo.userData.userAgentHash  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 19, [usuario.userInfo.userData.imgUser.big  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 20, [usuario.userInfo.userData.imgUser.small  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 21, [usuario.userInfo.userData.country.iso  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 22, [usuario.userInfo.userData.country.name  UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 23, [usuario.userInfo.error  UTF8String], -1, SQLITE_TRANSIENT);
            
            
            int resultado = sqlite3_step(stmt);
            if (resultado == SQLITE_DONE) {
                ////NSLog(@"Se ejecuto bien la query de InsertarMensaje");
            } else if (resultado == SQLITE_BUSY) {
                ////NSLog(@"No se ejecuto bien la query de InsertarMensaje: BUSY");
            } else if (resultado == SQLITE_ERROR) {
                ////NSLog(@"No se ejecuto bien la query de InsertarMensaje: ERROR");
            } else if (resultado == SQLITE_MISUSE) {
                ////NSLog(@"No se ejecuto bien la query de InsertarMensaje: MISUSE");
            } else if (resultado == SQLITE_CONSTRAINT) {
                ////NSLog(@"No se ejecuto bien la query de InsertarMensaje: CONSTRAINT");
            }
            sqlite3_finalize(stmt);
        } else {//no se preparo bien la query
            ////NSLog(@"No se preparo bien la query de InsertarMensaje");
        }
        
        
        sqlite3_close(database);
    } else {//No se abrio bien la base de datos
        
    }
    
}

-(void) borrarInformacionUsuario {
    [self createEditableCopyOfDatabaseIfNeeded];
    sqlite3 * database;
    sqlite3_stmt * stmt;
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:databaseName];
    //const unsigned char * devuelto;
    const char * dbPath = [path UTF8String];
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
        const char * sql = "DELETE FROM Usuario";
        if (sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK) {
            if (sqlite3_step(stmt) == SQLITE_DONE) {
                //NSLog(@"Se ejecuto bien la query");
            } else {
                //NSLog(@"No se ejecuto bien la query");
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    } else {
        //NSLog(@"fallo al abrir la base de datos");
    }
}*/

-(UserCredentials *) cargarUserCredentials {
    [self createEditableCopyOfDatabaseIfNeeded];
    BOOL hayCredentials = NO;
    const char * authToken;
    const char * authTokenExpiresDate;
    const char * authTokenError;
	const char * userToken;
    const char * userTokenExpiresDate;
    
    NSString * authTokenTexto;
    NSString * authTokenExpiresDateTexto;
    NSString * authTokenErrorTexto;
	NSString * userTokenTexto;
    NSString * userTokenExpiresDateTexto;
        
    sqlite3 * database;
    sqlite3_stmt * stmt;
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:databaseName];
    const char * dbPath = [path UTF8String];
    const char * sqlQuery;
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {//abrimos la base de datos
        sqlQuery = "select * from UserCredentials";
        if (sqlite3_prepare_v2(database, sqlQuery, -1, &stmt, NULL) == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                hayCredentials = YES;
                
                authToken = (const char *)sqlite3_column_text(stmt, 1);
                authTokenExpiresDate = (const char *)sqlite3_column_text(stmt, 2);
                authTokenError = (const char *)sqlite3_column_text(stmt, 3);
                userToken = (const char *)sqlite3_column_text(stmt, 4);
                userTokenExpiresDate = (const char *)sqlite3_column_text(stmt, 5);

                
                if (authToken != NULL) {
                    authTokenTexto = [NSString stringWithUTF8String:(const char*)authToken];
                }
                
                if (authTokenExpiresDate != NULL) {
                    authTokenExpiresDateTexto = [NSString stringWithUTF8String:(const char*)authTokenExpiresDate];
                }
                
                if (authTokenError != NULL) {
                    authTokenErrorTexto = [NSString stringWithUTF8String:(const char*)authTokenError];
                }
                
                if (userToken != NULL) {
                    userTokenTexto = [NSString stringWithUTF8String:(const char*)userToken];
                }
                
                if (userTokenExpiresDate != NULL) {
                    userTokenExpiresDateTexto = [NSString stringWithUTF8String:(const char*)userTokenExpiresDate];
                }
                
                sqlite3_finalize(stmt);
            }
        } else {//no se preparo bien la query
            NSLog(@"No se preparo bien la query de cargarUserCredentials");
        }
    }
    if (hayCredentials) {
        AuthToken * authToken = [[AuthToken alloc] initWithAuthToken:authTokenTexto AuthExpiresDate:[authTokenExpiresDateTexto longLongValue] Error:[authTokenErrorTexto intValue]];
        UserToken * userToken = [[UserToken alloc] initWithUserToken:userTokenTexto UserExpiresDate:[userTokenExpiresDateTexto longLongValue] Error:0];
        
        return [[UserCredentials alloc] initWithAuthToken:authToken UserToken:userToken];
    } else {
        return nil;
    }
}

-(void) guardarUserCredentials: (UserCredentials *) userCredentials {
    [self createEditableCopyOfDatabaseIfNeeded];
    sqlite3 * database;
    sqlite3_stmt * stmt;
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:databaseName];
    NSString * authTokenExpiresDate = [NSString stringWithFormat:@"%ld",userCredentials.authToken.authExpiresDate];
    NSString * authTokenError = [NSString stringWithFormat:@"%d",userCredentials.authToken.error];
    NSString * userTokenExpiresDate = [NSString stringWithFormat:@"%ld",userCredentials.userToken.userExpiresDate];

    const char * dbPath = [path UTF8String];
    const char * sqlQuery;
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {//abrimos la base de datos
        sqlQuery = "insert into UserCredentials (id,authToken,authTokenExpiresDate,authTokenError,userToken,userTokenExpiresDate) values (?,?,?,?,?,?)";
        
        if (sqlite3_prepare_v2(database, sqlQuery, -1, &stmt, NULL) == SQLITE_OK) {
            
            sqlite3_bind_int(stmt,1,0);
            sqlite3_bind_text(stmt, 2, [userCredentials.authToken.authToken UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 3, [authTokenExpiresDate UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 4, [authTokenError UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 5, [userCredentials.userToken.userToken UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 6, [userTokenExpiresDate UTF8String], -1, SQLITE_TRANSIENT);
            
            int resultado = sqlite3_step(stmt);
            if (resultado == SQLITE_DONE) {
                //NSLog(@"Se ejecuto bien la query de InsertarUserCredentials");
            } else if (resultado == SQLITE_BUSY) {
                NSLog(@"No se ejecuto bien la query de InsertarUserCredentials: BUSY");
            } else if (resultado == SQLITE_ERROR) {
                NSLog(@"No se ejecuto bien la query de InsertarUserCredentials: ERROR");
            } else if (resultado == SQLITE_MISUSE) {
                NSLog(@"No se ejecuto bien la query de InsertarUserCredentials: MISUSE");
            } else if (resultado == SQLITE_CONSTRAINT) {
                NSLog(@"No se ejecuto bien la query de InsertarUserCredentials: CONSTRAINT");
            }
            sqlite3_finalize(stmt);
        } else {//no se preparo bien la query
            NSLog(@"No se preparo bien la query de InsertarUserCredentials");
        }
        
        
        sqlite3_close(database);
    } else {//No se abrio bien la base de datos
        
    }
}

-(void) borrarUserCredentials {
    [self createEditableCopyOfDatabaseIfNeeded];
    sqlite3 * database;
    sqlite3_stmt * stmt;
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:databaseName];
    //const unsigned char * devuelto;
    const char * dbPath = [path UTF8String];
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
        const char * sql = "DELETE FROM UserCredentials";
        if (sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK) {
            if (sqlite3_step(stmt) == SQLITE_DONE) {
                //NSLog(@"Se ejecuto bien la query");
            } else {
                NSLog(@"No se ejecuto bien la query");
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    } else {
        NSLog(@"fallo al abrir la base de datos");
    }
}



@end
