//
//  VerLinkViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Link;
@interface VerLinkViewController : UIViewController

@property(strong,nonatomic) Link * link;
@property(strong,nonatomic) UIWebView * webView;

-(id) initWithLink: (Link *) link;

@end

@interface VerLinkViewControllerIpad : VerLinkViewController

@end

@interface VerLinkViewControllerIphone : VerLinkViewController

@end
