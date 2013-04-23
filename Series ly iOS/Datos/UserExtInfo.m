//
//  UserExtInfo.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 27/02/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "UserExtInfo.h"

@implementation UserExtInfo

- (id)initWithCp: (NSString *) cp Nom: (NSString *) nom Cognoms: (NSString *) cognoms DataNaixement: (NSString *) dataNaixement Sexe: (NSString *) sexe VeureNom: (NSString *) veureNom VeureEmail: (NSString *) veureEmail Lang: (NSString *) lang UserDescription: (NSString *) userDescription Profesion : (NSString *) profesion {
    self = [super init];
    if (self) {
        self.cp = cp;
        self.nom = nom;
        self.cognoms = cognoms;
        self.dataNaixement = dataNaixement;
        self.sexe = sexe;
        self.veureNom = veureNom;
        self.veureEmail = veureEmail;
        self.lang = lang;
        self.userDescription = userDescription;
        self.profesion = profesion;
    }
    return self;
}

@end
