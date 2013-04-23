//
//  CustomSplitViewController.h
//  CustomSplitView
//
//  Created by lorenzo villarroel perez on 31/12/11.
//  Copyright (c) 2011 Politecnica de Madrid. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class FirstDetailViewController,MasterViewController;

@interface CustomSplitViewController : UIViewController {
    /*@private
    //FirstDetailViewController * detailViewController;
    //MasterViewController * masterViewController;
    NSArray * viewControllers;
    UIBarButtonItem * botonHideShowDetail;
    UIBarButtonItem * botonHideShowMaster;*/
}

/*@property (strong, nonatomic) FirstDetailViewController * detailViewController;
@property (strong, nonatomic) MasterViewController * masterViewController;
@property (strong, nonatomic) UINavigationController * masterNavigationController;
@property (strong, nonatomic) UINavigationController * detailNavigationController;*/
@property (strong, nonatomic) NSArray * viewControllers;
@property (strong, nonatomic) IBOutlet UIView *masterView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) UIBarButtonItem * botonHideShowDetail;
//@property (strong, nonatomic) UIBarButtonItem * botonHideShowMaster;
//@property (strong, nonatomic) UISwipeGestureRecognizer * swipeRight;
//@property (strong, nonatomic) UISwipeGestureRecognizer * swipeLeft;
@property (strong, nonatomic) UITapGestureRecognizer * oneFingerOneTap;
@property (strong, nonatomic) UISwipeGestureRecognizer * swipeLeft;
@property (strong, nonatomic) UISwipeGestureRecognizer * swipeRight;
//-(void) initView;
-(void) hideMaster;
-(void) showMaster;
//- (IBAction)handleSwipeRight:(id)sender;
//- (IBAction)handleSwipeLeft:(id)sender;
//- (IBAction)oneFingerOneTap:(id)sender;
-(void) anadirTapGesture: (UIView *) view;

-(void) anadirHideButton: (UIViewController *) viewController;
-(void) anadirShowButton: (UIViewController *) viewController;
+ (CustomSplitViewController *) getInstance;
//- (IBAction)handleTap:(id)sender;

@end
