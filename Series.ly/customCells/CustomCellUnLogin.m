//
//  CustomCellUnLogin.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 08/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellUnLogin.h"
#import "PerfilViewController.h"

@implementation CustomCellUnLogin

-(void) executeAction: (UIViewController *) viewController {
    [PerfilViewController logout];
}

@end
