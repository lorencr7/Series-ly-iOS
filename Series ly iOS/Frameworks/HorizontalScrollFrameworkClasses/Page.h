//
//  Apartado.h
//  PruebaIphone
//
//  Created by Xavier Ferré on 14/06/12.
//  Copyright (c) 2012 Universidad Politécnica de Madrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Page : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *button;

-(void) reloadScroll:(UIScrollView *) scrollView;
-(void) loadData;
-(void) unloadData;

@end
