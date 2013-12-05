//
//  LoginLogoViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 05/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "LoginLogoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginLogoViewController ()

@end

@implementation LoginLogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) getData {
    return YES;
}

-(void) createData {
    [self createLabel];
    [self createLogo];
    [self stopActivityIndicator];
}

-(void) createLabel {
    CGRect frame = CGRectMake(0,
                              0,
                              self.view.frame.size.width,
                              40);
    self.labelTitulo = [[UILabel alloc] initWithFrame:frame];
    self.labelTitulo.backgroundColor = [UIColor clearColor];
    self.labelTitulo.font = [UIFont systemFontOfSize:22.0];
    self.labelTitulo.textAlignment = NSTextAlignmentCenter;
    self.labelTitulo.text = @"Series.ly";
    
    //[self.labelTitulo sizeToFit];
    
    [self.view addSubview:self.labelTitulo];
}

-(void) createLogo {
    int ancho = MIN(self.view.frame.size.width, self.view.frame.size.height);
    CGRect frame = CGRectMake(self.view.frame.size.width/2 - ancho/2,
                              self.labelTitulo.frame.origin.y + self.labelTitulo.frame.size.height + 10,
                              ancho,
                              ancho);
    self.imagenLogo = [[UIImageView alloc] initWithFrame:frame];
    self.imagenLogo.image = [UIImage imageNamed:@"logoSeriesly375x375"];
    self.imagenLogo.layer.borderWidth = 2;
    self.imagenLogo.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.imagenLogo];
}


@end
