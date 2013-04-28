//
//  CustomCellLinksLink.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellLinksLink.h"
#import "VerLinkViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "CustomSplitViewController.h"
#import "UserCredentials.h"
#import "Link.h"
#import "AuthToken.h"
#import "UserToken.h"


@implementation CustomCellLinksLink

-(id) initWithLink: (Link *) link {
    self = [super init];
    if (self) {
        self.link = link;
    }
    return self;
}

-(void) executeAction:(UIViewController *)viewController {
    //NSMutableArray * hostsForSafari = [NSMutableArray arrayWithObjects:@"AllMyVideos",@"Youtube" ,nil];
    VerLinkViewControllerIpad * verLinkViewController = [[VerLinkViewControllerIpad alloc] initWithLink:self.link];
    if ([self.link.host isEqualToString:@"AllMyVideos"]) {
         UserCredentials * userCredentials = [UserCredentials getInstance];
        NSString * urlString = [NSString stringWithFormat:@"http://api.series.ly/v2/media/link/go/%@?auth_token=%@&user_token=%@",self.link.idv,userCredentials.authToken.authToken,userCredentials.userToken.userToken];
        NSLog(@"url %@",urlString);
        NSURL * url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:verLinkViewController];
        navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
        navigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate.drawerViewController presentViewController:navigationController animated:YES completion:nil];
        } else {
            [viewController presentViewController:navigationController animated:YES completion:nil];
        }
    }
}

@end


