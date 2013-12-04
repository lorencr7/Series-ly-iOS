//
//  TratadorImagenes.m
//  PrototipoElMundo
//
//  Created by Lorenzo Villarroel on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TratadorImagenes.h"
static TratadorImagenes * instance;

@implementation TratadorImagenes

/**
@Method getInstance
@Description Devuelve la instancia de la clase ManejadorBaseDeDatosBackup
@Return La instancia de ManejadorBaseDeDatosBackup
**/
+ (TratadorImagenes *) getInstance {
    if (instance == nil) {
        instance = [[TratadorImagenes alloc] init];
    }
    return instance;
}

-(void) reescalarImagen: (UIImageView *) imageView  maxHeight: (int)maxHeight maxWidth: (int)maxWidth {
    UIImage * image = imageView.image;
    CGRect frame = imageView.frame;
    if (image.size.width > image.size.height) {//x > y , apaisada
        double proporcion = maxWidth/image.size.width ;
        frame.size.width = image.size.width * proporcion;
        frame.size.height = image.size.height * proporcion;
        ////NSLog(@"proporcion1 = %.3f",proporcion);
    } else if (image.size.width < image.size.height){//x < y , retrato
        double proporcion = maxHeight/image.size.height ;
        frame.size.width = image.size.width * proporcion;
        frame.size.height = image.size.height * proporcion;
        ////NSLog(@"proporcion2 = %.3f",proporcion);
    } else {// x == y , cuadrada
        frame.size.width = maxWidth;
        frame.size.height = maxWidth;
    }
    //[imageView performSelectorOnMainThread:@selector(setFrame:) withObject:frame waitUntilDone:YES];
    //imageView.frame = frame;
    NSMutableDictionary * arguments = [NSMutableDictionary dictionary];
    [arguments setObject:imageView forKey:@"imageView"];
    [arguments setObject:[NSValue valueWithCGRect:frame] forKey:@"frame"];
    [self performSelectorOnMainThread:@selector(setFrameToImageView:) withObject:arguments waitUntilDone:YES];

    /*dispatch_sync(dispatch_get_main_queue(), ^{
        [self setFrame:frame ToImageView:imageView];
    });*/
}

-(void) setFrame: (CGRect) frame ToImageView: (UIImageView *) imageView {
    imageView.frame = frame;
}

-(void) setFrameToImageView: (NSMutableDictionary *) arguments {
    UIImageView * imageView = arguments[@"imageView"];
    NSValue * frameValue = (arguments[@"frame"]);
    CGRect frame = [frameValue CGRectValue];
    imageView.frame = frame;
}

/**
@Method reescalarImagen
@Description Reescala la imagen manteniendo sus proporciones
@Param imageView - La imagen que se quiere rescalar
@Param view - La vista en la que se quiere reescalar la imagen
@Return void
**/
-(void) reescalarImagen: (UIImageView *) imageView  enView: (UIView *) view {
    UIImage * image = imageView.image;
    CGRect frame = imageView.frame;
    if (image.size.width > image.size.height) {//x > y , apaisada
        double proporcion = view.frame.size.width*0.9 /image.size.width ; 
        frame.size.width = image.size.width * proporcion;
        frame.size.height = image.size.height * proporcion;
    } else if (image.size.width < image.size.height){//x < y , retrato
        double proporcion = view.frame.size.height*0.8 /image.size.height ;
        frame.size.width = image.size.width * proporcion;
        frame.size.height = image.size.height * proporcion;
    } else {// x == y , cuadrada
        frame.size.width = view.frame.size.width*0.9;
        frame.size.height = view.frame.size.width*0.9;
    }
    imageView.frame = frame;
}

/**
@Method reescalarImagen
@Description Centra la imagen dejando unos pequeños margenes
@Param imageView - La imagen que se quiere centrar
@Param view - La vista en la que se quiere centrar la imagen
@Return void
**/
-(void) centrarImagen:(UIImageView *) imagen EnView:(UIView *) view {
    int margen = view.frame.size.width * 0.05;
    CGRect frame = imagen.frame;
    if (frame.size.width >= frame.size.height) {//foto apaisada
        frame.origin = CGPointMake(margen, frame.origin.y);
    } else if (frame.size.width < frame.size.height) {
        frame.origin = CGPointMake(view.frame.size.width*0.5 - frame.size.width*0.5, frame.origin.y);
    }
    imagen.frame = frame;
}


@end
