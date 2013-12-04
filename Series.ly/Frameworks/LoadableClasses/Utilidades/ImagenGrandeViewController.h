//
//  ImagenGrandeViewController.h
//  Prototipo El Mundo
//
//  Created by Laboratorio Ingeniería Software on 21/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería del Software. All rights reserved.
//

#import "RootViewController.h"

/**
 @Class ImagenGrandeViewController
 @Description esta clase se encarga de mostrarnos una foto a pantalla completa para poderla ver mejor
 @Attribute scrollView - sobre el que se situara la foto
 @Attribute imageView - ira encima del scrollView y sobre el ira la foto
 @Attribute minZoomScale - minimo valor de zoom
 @Attribute maxZoomScale - maximo valor de zoom
 @Property image - imagen que tenemos que mostrar
 @Method initWithImage 
 **/
@interface ImagenGrandeViewController : RootViewController <UIScrollViewDelegate> {
    UIScrollView* scrollView;
    UIImageView *imageView;
    
    float minZoomScale;
    float maxZoomScale;
}

@property(strong, nonatomic) UIImage *image;

- (id)initWithImage:(UIImage *) image;

@end
