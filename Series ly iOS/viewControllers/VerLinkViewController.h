//
//  VerLinkViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerLinkViewController : UIViewController

@property(strong,nonatomic) NSString * idv;
@property(strong,nonatomic) UIWebView * webView;

-(id) initWithIdv: (NSString *) idv;

@end

@interface VerLinkViewControllerIpad : VerLinkViewController

@end

@interface VerLinkViewControllerIphone : VerLinkViewController

@end
