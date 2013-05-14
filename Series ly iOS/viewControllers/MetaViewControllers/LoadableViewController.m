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


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self iniciarActivityIndicator];
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
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
}

-(void) stopActivityIndicator {
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
}

//Este metodo se descarga una imagen de internet y la asigna a su imageView correspondiente
-(void) configureImageView: (NSMutableDictionary *) arguments {
    UIImageView * imageView = [arguments objectForKey:@"imageView"];
    NSString * url = [arguments objectForKey:@"url"];
    UIImage * imagen;
    NSURL * imageURL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:imageURL];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        NSData * imageData = [request responseData];
        imagen = [UIImage imageWithData:imageData];
        imageView.image = imagen;
    }
}

@end
