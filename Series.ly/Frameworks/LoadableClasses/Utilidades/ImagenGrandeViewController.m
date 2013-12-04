//
//  ImagenGrandeViewController.m
//  Prototipo El Mundo
//
//  Created by Laboratorio Ingeniería Software on 21/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería del Software. All rights reserved.
//

#import "ImagenGrandeViewController.h"

/**
 @Class ImagenGrandeViewController
 @Description esta clase se encarga de mostrarnos una foto a pantalla completa para poderla ver mejor
 @Method initWithImage
 @Method viewDidLoad
 @Method didReceiveMemoryWarning
 @Method loadImageView
 @Method loadScrollWithImageView
 @Method handlerDone
 @Method doubleTapToZoom
 @Method viewForZoomingInScrollView
 **/
@interface ImagenGrandeViewController ()

@end

@implementation ImagenGrandeViewController

/**
 @Method initWithImage
 @Description metodo init personalizado para aceptar el parametro imagen 
 @Param (UIImage *) image - imagen que vamos a mostrar a tamaño completo
 @Return id
 **/
- (id)initWithImage:(UIImage *) image
{    
    self = [super init];
    if (self) {
        self.image = image;
        self.title = NSLocalizedString(@"ImageBig", nil);
        minZoomScale = 1;
        maxZoomScale = 3;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"CloseWindow", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(handlerDone)];
    self.navigationItem.leftBarButtonItem = done;
    //self.view.backgroundColor = [UIColor colorWithRed:(190/255.0) green:(187/255.0) blue:(186/255.0) alpha:1.0];
    self.view.backgroundColor = [UIColor blackColor];
    // Cargamos los elementos que van sobre el view
    [self loadImageView];
    [self loadScrollWithImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 @Method loadImageView
 @Description metod que se encarga de cargar el imageView 
 @Return void
 **/
-(void) loadImageView {
    imageView = [[UIImageView alloc] init];
    double proporcion = self.view.frame.size.width/self.image.size.width;
    
    CGRect frame;
    frame.size.width = self.image.size.width * proporcion;
    frame.size.height = self.image.size.height * proporcion;
    frame.origin.x = 0;
    frame.origin.y = 0;
    imageView.frame = frame;
    imageView.image = self.image;
}

/**
 @Method loadScrollWithImageView
 @Description metodo que se encarga de cargar el scrollView y el imageView
 @Return void
 **/
-(void) loadScrollWithImageView {
    CGRect scrollViewFrame = self.view.frame;
    scrollViewFrame.origin.y = 0;
    scrollView =[[UIScrollView alloc] initWithFrame:scrollViewFrame];
    [scrollView setContentSize: CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.delegate = self;
    
    scrollView.contentMode = (UIViewContentModeScaleAspectFit);
    scrollView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    // Indicamos los valores maximo y minimo de zoom posibles 
    scrollView.maximumZoomScale = maxZoomScale;
    scrollView.minimumZoomScale = minZoomScale;
    scrollView.clipsToBounds = YES;
    
    // Add Gestures
    UITapGestureRecognizer* tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapToZoom:)];
    [tapRecognizer setNumberOfTapsRequired:2];
    [scrollView addGestureRecognizer:tapRecognizer];
    
    //UIPinchGestureRecognizer* pinch=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchToZoom:)];
    //[scrollView addGestureRecognizer:pinch];
    
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
}

/**
 @Method handlerDone
 @Description metodo encargado de controlar la accion que se realiza cuando se pulsa sobre el boton de Hecho 
 @Return void
 **/
-(void) handlerDone {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 @Method doubleTapToZoom
 @Description metodo que se encarga de controlar la accion que hace el gestureReconizer dobleTap
 @Param (UITapGestureRecognizer *)recognizer
 @Return void
 **/
- (void) doubleTapToZoom:(UITapGestureRecognizer *)recognizer {
    static BOOL zoomed=NO;
    
    if (!zoomed) { // si no hay zoom hecho
        [scrollView zoomToRect:CGRectMake([recognizer locationInView:recognizer.view].x, [recognizer locationInView:recognizer.view].y, scrollView.frame.size.width/maxZoomScale, scrollView.frame.size.height/maxZoomScale) animated:YES];
        zoomed=YES;
    } else {  // si ya habia zoom
        [scrollView zoomToRect:CGRectMake(0,
                                          0,
                                          scrollView.frame.size.width,
                                          scrollView.frame.size.height) animated:YES];
        zoomed=NO;
    }
}


/**
 @Method viewForZoomingInScrollView
 @Description nos devuelve sobre quien se esta haciendo zoom
 @Param (UIScrollView *)scrollView 
 @Return (UIView *)
 **/
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

@end
