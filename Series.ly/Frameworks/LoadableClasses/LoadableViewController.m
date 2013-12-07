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
//#import "NSData+Base64.h"
#import "TratadorImagenes.h"

@interface LoadableViewController ()

@end

@implementation LoadableViewController

- (id)init {
    self = [super init];
    if (self) {
        [self iniciarObjetos];
    }
    return self;
}

- (id)initWithFrame: (CGRect) frame {
    self = [super init];
    if (self) {
        self.frame = frame;
        [self iniciarObjetos];
    }
    return self;
}

-(void) iniciarObjetos {
    //self.requests = [NSMutableArray array];
    //self.threads = [NSMutableArray array];
    
    self.mensajeSinConexion = NSLocalizedString(@"BugNoConexion", nil);
    self.mensajeErrorDescarga = NSLocalizedString(@"BugLoadData", nil);
    self.mensajeDatosVacios = NSLocalizedString(@"BugNoElementsAvaible", nil);
    
    self.firstLoad = YES;
    self.imagenes = [NSMutableArray array];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = self.frame;
    self.view.backgroundColor = [UIColor clearColor];
    [self iniciarActivityIndicator];
    [self iniciarActivityIndicatorForeGround];
    [self activateActivityIndicator];
    [self performSelectorInBackground:@selector(loadData) withObject:nil];
}

-(void) viewWillAppear:(BOOL)animated {
    self.firstLoad = NO;
}

-(void) loadData {
    //[self.threads addObject:[NSThread currentThread]];
    BOOL hayData = [self getData];
    if (!hayData) {
        [self createErrorMessage];
        [self stopActivityIndicator];
    } else {
        [self performSelectorOnMainThread:@selector(createData) withObject:nil waitUntilDone:YES];
        //[self createData];
    }
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    //[self.threads removeObject:[NSThread currentThread]];
    //self.firstLoad = NO;
}

-(BOOL) getData {
    return YES;
}

-(void) createData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarActivityIndicator {
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //UIColor * color = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    UIColor * color = [UIColor blackColor];
    [activityIndicator setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    activityIndicator.color = color;
    activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
    [activityIndicator startAnimating];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 0, 0)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 1;
    NSString * loadingFeedbackText;
    if (self.title) {
        loadingFeedbackText = [NSString stringWithFormat:@"%@ %@...", NSLocalizedString(@"Loading", nil),self.title];
    } else {
        loadingFeedbackText = NSLocalizedString(@"Loading...", nil);
    }
    label.text = loadingFeedbackText;
    [label sizeToFit];
    
    CGRect frame = label.frame;
    frame.origin.x = (activityIndicator.frame.size.width/2) - (label.frame.size.width/2);
    label.frame = frame;
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    
    [activityIndicator addSubview:label];

}

-(void) createErrorMessage {
    
}

-(void) activateActivityIndicator {
    [self.view addSubview:activityIndicator];
    [activityIndicator performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:YES];

    //[activityIndicator startAnimating];
}

-(void) stopActivityIndicator {
    [activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
    [activityIndicator performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:YES];
    //[activityIndicator stopAnimating];
    //[activityIndicator removeFromSuperview];
}

-(void) iniciarActivityIndicatorForeGround {
    activityIndicatorForeGround = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //UIColor * color = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    UIColor * color = [UIColor whiteColor];
    [activityIndicatorForeGround setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    activityIndicatorForeGround.color = color;
    activityIndicatorForeGround.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
    [activityIndicatorForeGround.layer setBackgroundColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]];
    [activityIndicatorForeGround startAnimating];
    
}

-(void) activateActivityIndicatorForeGround {
    [self.view addSubview:activityIndicatorForeGround];
    [activityIndicatorForeGround performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:YES];
}

-(void) stopActivityIndicatorForeGround {
    [activityIndicatorForeGround performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
    [activityIndicatorForeGround performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:YES];
}

-(void) configureImagenes: (NSMutableArray *) imagenes {
    NSMutableArray * imagenesCopy = [NSMutableArray arrayWithArray:imagenes];
    for (NSMutableDictionary * imagen in imagenesCopy) {
        [self configureImageView:imagen];
    }
    //NSLog(@"%d Imagenes descargada",imagenesCopy.count);
}

//Este metodo se descarga una imagen de internet y la asigna a su imageView correspondiente
-(void) configureImageView: (NSMutableDictionary *) arguments {
    //[self.threads addObject:[NSThread currentThread]];
    UIImageView * imageView = arguments[@"imageView"];
    NSString * url = arguments[@"url"];
    NSNumber * maxHeight = arguments[@"maxHeight"];
    NSNumber * maxWidth = arguments[@"maxWidth"];
    UIImage * imagen;
    
    url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //NSLog(@"url: %@",url);
    NSURL * imageURL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:imageURL];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    //[request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    //[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    //[request setNumberOfTimesToRetryOnTimeout:2];
    //[self.requests addObject:request];
    
    [request startSynchronous];

    
    if (maxHeight && maxWidth) {
        TratadorImagenes * tratadorImagenes = [TratadorImagenes getInstance];
        [tratadorImagenes reescalarImagen:imageView maxHeight:maxHeight.intValue maxWidth:maxWidth.intValue];
    }

    
    //[self.requests removeObject:request];
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    
    NSError *error = [request error];
    if (!error) {
        NSData * imageData = [request responseData];
        imagen = [UIImage imageWithData:imageData];
        [imageView performSelectorOnMainThread:@selector(setImage:) withObject:imagen waitUntilDone:NO];
        //NSLog(@"poniendo imagen");
        //imageView.image = imagen;
    } else {
        NSLog(@"%@",error);
    }
}

-(void) cancelThreadsAndRequests {
    activityIndicator = nil;
    for (UIViewController * viewcontroller in self.childViewControllers) {
        if ([viewcontroller respondsToSelector:@selector(cancelThreadsAndRequests)]) {
            [viewcontroller performSelector:@selector(cancelThreadsAndRequests) withObject:nil];
        }
        [viewcontroller removeFromParentViewController];
    }
    /*for (int i = 0; i < self.threads.count; i++) {
        NSThread * thread = self.threads[i];
        if ([thread isExecuting]) {
            [thread cancel];
        }
    }
    for (int i = 0; i < self.requests.count; i++) {
        ASIHTTPRequest * request = self.requests[i];
        [request cancel];
    }*/
}

-(void) clearView {
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
}




@end
