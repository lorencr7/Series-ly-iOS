//
//  UserExtInfo.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserExtInfo : NSObject

@property (strong,nonatomic) NSString * cp;
@property (strong,nonatomic) NSString * nom;
@property (strong,nonatomic) NSString * cognoms;
@property (strong,nonatomic) NSString * dataNaixement;
@property (strong,nonatomic) NSString * sexe;
@property (strong,nonatomic) NSString * veureNom;
@property (strong,nonatomic) NSString * veureEmail;
@property (strong,nonatomic) NSString * lang;
@property (strong,nonatomic) NSString * userDescription;
@property (strong,nonatomic) NSString * profesion;

- (id)initWithCp: (NSString *) cp Nom: (NSString *) nom Cognoms: (NSString *) cognoms DataNaixement: (NSString *) dataNaixement Sexe: (NSString *) sexe VeureNom: (NSString *) veureNom VeureEmail: (NSString *) veureEmail Lang: (NSString *) lang UserDescription: (NSString *) userDescription Profesion : (NSString *) profesion;

@end
