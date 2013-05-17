//
//  CustomSplitViewController.h
//  CustomSplitView
//
//  Created by lorenzo villarroel perez on 31/12/11.
//  Copyright (c) 2011 Politecnica de Madrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSplitViewController : UIViewController <UIGestureRecognizerDelegate>{
    int panApplied;
}

@property (strong, nonatomic) NSArray * viewControllers;
@property (strong, nonatomic) UIView *masterView;
@property (strong, nonatomic) UIView *detailView;
@property (strong, nonatomic) UIBarButtonItem * botonHideShowDetail;
@property (strong, nonatomic) NSMutableArray * buttons;


@property (strong, nonatomic) UITapGestureRecognizer * oneFingerOneTap;
@property (strong, nonatomic) UIPanGestureRecognizer * oneFngerPan;

-(void) hideMaster;
-(void) showMaster;


+ (CustomSplitViewController *) getInstance;

@end
