//
//  CustomCellLinksLink.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellLinksLink.h"
#import "VerLinkViewController.h"

@implementation CustomCellLinksLink

-(id) initWithIdv: (NSString *) idv {
    self = [super init];
    if (self) {
        self.idv = idv;
    }
    return self;
}

-(void) executeAction:(UIViewController *)viewController {
    VerLinkViewControllerIpad * verLinkViewController = [[VerLinkViewControllerIpad alloc] initWithIdv:self.idv];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:verLinkViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
    [viewController presentViewController:navigationController animated:YES completion:nil];
}

@end


