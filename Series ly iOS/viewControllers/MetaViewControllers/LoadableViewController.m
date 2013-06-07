//
//  LoadableViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"


@interface LoadableViewController ()

@end

@implementation LoadableViewController

- (id)init {
    self = [super init];
    if (self) {
        self.requests = [NSMutableArray array];
        self.threads = [NSMutableArray array];
        
        self.mensajeSinConexion = @"Error al cargar los datos. No hay conexion a internet.";
        self.mensajeErrorDescarga = @"Error al cargar los datos.";
        self.mensajeDatosVacios = @"No hay elementos disponibles.";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self iniciarActivityIndicator];
    [self performSelectorOnMainThread:@selector(activateActivityIndicator) withObject:nil waitUntilDone:YES];
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    [thread start];
    //[self.threads addObject:thread];
}

-(void) loadData {
    [self.threads addObject:[NSThread currentThread]];
    BOOL hayData = [self getData];
    if (hayData) {
        
    } else {
        [self createErrorMessage];
        [self stopActivityIndicator];
    }
    [self.threads removeObject:[NSThread currentThread]];
}

-(BOOL) getData {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarActivityIndicator {
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    activityIndicator.color = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
    [activityIndicator startAnimating];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 0, 0)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 1;
    label.text = @"Cargando...";
    [label sizeToFit];
    
    CGRect frame = label.frame;
    frame.origin.x = (activityIndicator.frame.size.width/2) - (label.frame.size.width/2);
    label.frame = frame;
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    
    [activityIndicator addSubview:label];
    
    //[self activateActivityIndicator];
    
}

-(void) createErrorMessage {
    
}

-(void) activateActivityIndicator {
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

-(void) stopActivityIndicator {
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
}

//Este metodo se descarga una imagen de internet y la asigna a su imageView correspondiente
-(void) configureImageView: (NSMutableDictionary *) arguments {
    [self.threads addObject:[NSThread currentThread]];
    UIImageView * imageView = [arguments objectForKey:@"imageView"];
    NSString * url = [arguments objectForKey:@"url"];
    UIImage * imagen;
    NSURL * imageURL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:imageURL];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    //[request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy];
    //[request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [self.requests addObject:request];
    [request startSynchronous];
    [self.requests removeObject:request];
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    
    NSError *error = [request error];
    if (!error) {
        NSData * imageData = [request responseData];
        imagen = [UIImage imageWithData:imageData];
        imageView.image = imagen;
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    /*for (NSThread * thread in self.threads) {
        if ([thread isExecuting]) {
            [thread cancel];
        }
    }
    for (int i = 0; i < self.requests.count; i++) {
        ASIHTTPRequest * request = self.requests[i];
        [request cancel];
    }*/
}

-(void) cancelThreadsAndRequests {
    for (NSThread * thread in self.threads) {
        if ([thread isExecuting]) {
            [thread cancel];
        }
    }
    for (int i = 0; i < self.requests.count; i++) {
        ASIHTTPRequest * request = self.requests[i];
        [request cancel];
    }
}




@end
