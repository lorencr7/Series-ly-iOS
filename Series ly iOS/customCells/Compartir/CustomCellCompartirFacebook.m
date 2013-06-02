//
//  CustomCellCompartirFacebook.m
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 02/06/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellCompartirFacebook.h"
#import "MediaElement.h"
#import "ShareFacebook.h"

@implementation CustomCellCompartirFacebook

-(void) executeAction:(UIViewController *)viewController {
    NSString * postToFacebookText = [NSString stringWithFormat:@"Estoy viendo %@ en Series.ly",self.mediaElement.name];
    [[ShareFacebook getInstance] postToFacebookText:postToFacebookText foto:nil urlString:self.mediaElement.url viewController:viewController];
}

@end
