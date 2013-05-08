//
//  DownloadableViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 08/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DownloadableViewController.h"

@interface DownloadableViewController ()

@end

@implementation DownloadableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarActivityIndicator {
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicatorView setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    self.activityIndicatorView.color = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    self.activityIndicatorView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
    [self.activityIndicatorView startAnimating];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 0, 0)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 1;
    label.text = [NSString stringWithFormat:@"Cargando..."];
    [label sizeToFit];
    
    CGRect frame = label.frame;
    frame.origin.x = (self.activityIndicatorView.frame.size.width/2) - (label.frame.size.width/2);
    label.frame = frame;
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    
    [self.activityIndicatorView addSubview:label];
    
    [self.view addSubview:self.activityIndicatorView];
}

@end
