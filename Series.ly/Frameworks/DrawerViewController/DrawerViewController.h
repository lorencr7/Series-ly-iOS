//
//  NotificationViewController.h
//  FI UPM
//
//  Created by Lorenzo Villarroel on 03/04/13.
//  Copyright (c) 2013 Laboratorio Ingeniería del Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController <UIGestureRecognizerDelegate> {
    int panApplied;
}

@property(strong, nonatomic) NSArray * viewControllers;

@property(strong, nonatomic) UIView * drawerView;
@property(strong, nonatomic) UIView * mainView;

@property(strong, nonatomic) UITapGestureRecognizer * oneFingerOneTap;
//@property(strong, nonatomic) UISwipeGestureRecognizer * swipeRight;
//@property(strong, nonatomic) UISwipeGestureRecognizer * swipeLeft;
@property(strong, nonatomic) UIPanGestureRecognizer * oneFngerPan;

@property(strong, nonatomic) NSMutableArray * buttons;
//@property(strong, nonatomic) UIBarButtonItem * lastButtonPressed;
-(void) showDrawer;
-(void) hideDrawer;

-(UIViewController *) getDrawerViewController;
-(UIViewController *) getMainViewController;

@end
