//
//  TratadorImagenes.h
//  PrototipoElMundo
//
//  Created by Lorenzo Villarroel on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 
@Class ManejadorBaseDeDatosBackup
@Description Esta clase se encarga de reescalar una imagen de proporciones AxB a otra de proporciones CxD que se ajuste a la pantalla del iPhone
@Method getInstance
@Method reescalarImagen
@Method centrarImagen
**/
@interface TratadorImagenes : NSObject

+ (TratadorImagenes *) getInstance;


-(void) reescalarImagen: (UIImageView *) imageView  maxHeight: (int)maxHeight maxWidth: (int)maxWidth;
-(void) reescalarImagen: (UIImageView *) imageView  enView: (UIView *) view;
-(void) centrarImagen:(UIImageView *) imagen EnView:(UIView *) view;

@end
