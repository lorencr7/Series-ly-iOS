//
//  ViewControllerRedactar.h
//  PruebaIphone
//
//  Created by Xavier Ferre on 08/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Page.h"
//#import "ApartadoRedactar.h"
//#import "ApartadoMultimedia.h"
//#import "ApartadoSocial.h"

typedef enum {
    HPSelectionIndicatorAndroid,
    HPSelectionIndicatorShadow
} HPSelectionIndicator;

@class Page;
@interface HorizontalPagedScrollViewController : UIViewController <UIScrollViewDelegate> {
    @private
    //ApartadoRedactar *apartadoRedactar;
    //ApartadoMultimedia *apartadoMultimedia;
    //ApartadoSocial *apartadoSocial;
    CGFloat lastContentOffset;
    CGFloat cambioContentOffset;
    
    double mover;
}

/*@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonCancel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonSend;
@property (weak, nonatomic) IBOutlet UILabel *seleccionado;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonRedactar;
@property (weak, nonatomic) IBOutlet UIButton *buttonSocial;
@property (weak, nonatomic) IBOutlet UIButton *buttonCamera;
@property (weak, nonatomic) IBOutlet UIImageView *fotoFacebook;
@property (weak, nonatomic) IBOutlet UIImageView *fotoTwitter;*/
@property (assign, nonatomic) int buttonHeight;
@property (strong, nonatomic) NSArray *pages;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIViewController *rootViewController;
@property (strong, nonatomic) UILabel * selected;
@property (assign, nonatomic) BOOL positionTop;
@property (assign, nonatomic) HPSelectionIndicator selectionIndicator;

/*- (IBAction)handlerCancel:(id)sender;
- (IBAction)handlerSend:(id)sender;
- (IBAction)handlerButtons:(UIButton *)sender;
+ (HorizontalPagedScrollViewController *) getInstance;*/
-(void) loadData;
- (id)initWithFrame: (CGRect) frame Pages: (NSArray *) pages ButtonHeight: (int) buttonHeight PositionTop: (BOOL) positionTop selectionIndicator: (HPSelectionIndicator) selectionIndicator;
- (id)initWithFrame: (CGRect) frame Pages: (NSArray *) pages ButtonHeight: (int) buttonHeight PositionTop: (BOOL) positionTop RootViewController: (UIViewController*) rootViewController selectionIndicator: (HPSelectionIndicator) selectionIndicator;

@end
