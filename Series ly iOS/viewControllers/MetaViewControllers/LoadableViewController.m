//
//  LoadableViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 14/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"
#import "ASIHTTPRequest.h"


@interface LoadableViewController ()

@end

@implementation LoadableViewController

- (id)init {
    self = [super init];
    if (self) {
        self.requests = [NSMutableArray array];
        self.threads = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self iniciarActivityIndicator];
    [self performSelectorOnMainThread:@selector(activateActivityIndicator) withObject:nil waitUntilDone:YES];
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    [thread start];
    [self.threads addObject:thread];
}

-(void) loadData {
    [self getData];
    [self.threads removeObject:[NSThread currentThread]];
}

-(void) getData {
    
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
    for (NSThread * thread in self.threads) {
        if ([thread isExecuting]) {
            [thread cancel];
        }
    }
    for (ASIHTTPRequest * request in self.requests) {
        [request cancel];
    }
}




@end
