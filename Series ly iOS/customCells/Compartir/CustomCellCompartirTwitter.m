//
//  CustomCellCompartirTwitter.m
//  Series ly
//
//  Created by Lorenzo Villarroel Pérez on 02/06/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellCompartirTwitter.h"
#import "MediaElement.h"
#import "ShareTwitter.h"

@implementation CustomCellCompartirTwitter

-(void) executeAction:(UIViewController *)viewController {
    NSString * postToTwitterText = [NSString stringWithFormat:@"Estoy viendo %@ en Series.ly",self.mediaElement.name];
    [[ShareTwitter getInstance] postToTwitterText:postToTwitterText foto:nil urlString:self.mediaElement.url viewController:viewController];
}

@end
