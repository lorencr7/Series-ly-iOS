//
//  Apartado.m
//  PruebaIphone
//
//  Created by Xavier Ferré on 14/06/12.
//  Copyright (c) 2012 Universidad Politécnica de Madrid. All rights reserved.
//

#import "Page.h"

@interface Page ()
    
@end

@implementation Page

@synthesize button = _button;

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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) loadData{}
-(void) unloadData{}

-(void) reloadScroll:(UIScrollView *) scrollView {
    [scrollView addSubview:self.view];
    return;
}


@end
