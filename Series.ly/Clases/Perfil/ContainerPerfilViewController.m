//
//  ContainerPerfilViewController.m
//  Series.ly
//
//  Created by Lorenzo Villarroel Pérez on 05/12/13.
//  Copyright (c) 2013 Lorenzov. All rights reserved.
//

#import "ContainerPerfilViewController.h"
#import "PerfilViewController.h"

@interface ContainerPerfilViewController ()

@end

@implementation ContainerPerfilViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"Perfil";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundColor];
    [self createPerfilView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createPerfilView {
    CGRect frame = CGRectMake(0,
                              0,
                              self.view.frame.size.width,
                              self.view.frame.size.height);
    self.perfilViewController = [[PerfilViewController alloc] initWithFrame:frame];
    [self addChildViewController:self.perfilViewController];
    [self.view addSubview:self.perfilViewController.view];
}


@end
