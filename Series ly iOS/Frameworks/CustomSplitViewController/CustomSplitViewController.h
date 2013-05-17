//
//  CustomSplitViewController.h
//  CustomSplitView
//
//  Created by lorenzo villarroel perez on 31/12/11.
//  Copyright (c) 2011 Politecnica de Madrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSplitViewController : UIViewController

@property (strong, nonatomic) NSArray * viewControllers;
@property (strong, nonatomic) IBOutlet UIView *masterView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) UIBarButtonItem * botonHideShowDetail;

@property (strong, nonatomic) UITapGestureRecognizer * oneFingerOneTap;
@property (strong, nonatomic) UISwipeGestureRecognizer * swipeLeft;
@property (strong, nonatomic) UISwipeGestureRecognizer * swipeRight;

-(void) hideMaster;
-(void) showMaster;

-(void) anadirTapGesture: (UIView *) view;

-(void) anadirHideButton: (UIViewController *) viewController;
-(void) anadirShowButton: (UIViewController *) viewController;
+ (CustomSplitViewController *) getInstance;

@end
