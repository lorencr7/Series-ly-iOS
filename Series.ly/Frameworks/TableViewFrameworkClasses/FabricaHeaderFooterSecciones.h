//
//  FabricaTitulosSecciones.h
//  Custom Table View
//
//  Created by Lorenzo Villarroel on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*    CustomHeaderFooterAppearance * aparienciaHeaderElMundo = [[CustomHeaderFooterAppearance alloc]
 initWithAppearance:LABELFRAMEAULATITULO1(9, 10,self.view.frame.size.width/2,30)
 labelBackgroundColor:[UIColor colorWithRed:(152.0/255.0) green:(151.0/255.0) blue:(149.0/255.0) alpha:1]
 labelTextColor:[UIColor blackColor]
 labelTextFont:[UIFont boldSystemFontOfSize:15]
 labelTextAlignment:NSTextAlignmentCenter
 labelBorderColor:[UIColor blackColor]
 labelBorderWidth:0.8
 labelBorderRadius:LABELBORDERRADIUSAULATITULO1];*/
#import <Foundation/Foundation.h>

#define LABELFRAMEAULATITULO1(x,y,w,h) CGRectMake(x, y, w, h)
#define LABELBACKGROUNDCOLORAULATITULO1 [UIColor colorWithRed:(215.0/255.0) green:(214.0/255.0) blue:(211.0/255.0) alpha:1.0]
#define LABELTEXTCOLORAULATITULO1 [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(100/255.0) alpha:1]
#define LABELTEXTAULATITULO1(texto) texto
#define LABELTEXTFONTAULATITULO1 [UIFont boldSystemFontOfSize:16.0]
#define LABELTEXTALIGNMENTAULATITULO1 NSTextAlignmentCenter
#define LABELBORDERCOLORAULATITULO1 [UIColor colorWithRed:(215.0/255.0) green:(214.0/255.0) blue:(211.0/255.0) alpha:1.0]
#define LABELBORDERWIDTHAULATITULO1 1
#define LABELBORDERRADIUSAULATITULO1 0

#define HEADERAULATITULO1(x,y,w,h) [[CustomHeaderFooterAppearance alloc] initWithAppearance:LABELFRAMEAULATITULO1(x,y,w,h) labelBackgroundColor:LABELBACKGROUNDCOLORAULATITULO1 labelTextColor:LABELTEXTCOLORAULATITULO1 labelTextFont:LABELTEXTFONTAULATITULO1 labelTextAlignment:LABELTEXTALIGNMENTAULATITULO1 labelBorderColor:LABELBORDERCOLORAULATITULO1 labelBorderWidth:LABELBORDERWIDTHAULATITULO1 labelBorderRadius:LABELBORDERRADIUSAULATITULO1]

#define LABELFRAMEAULATITULO2(x,y,w,h) CGRectMake(x, y, w, h)
#define LABELBACKGROUNDCOLORAULATITULO2 [UIColor colorWithRed:(152.0/255.0) green:(151.0/255.0) blue:(149.0/255.0) alpha:1]
#define LABELTEXTCOLORAULATITULO2 [UIColor whiteColor]
#define LABELTEXTAULATITULO2(texto) texto
#define LABELTEXTFONTAULATITULO2 [UIFont boldSystemFontOfSize:16.0]
#define LABELTEXTALIGNMENTAULATITULO2 NSTextAlignmentCenter
#define LABELBORDERCOLORAULATITULO2 [UIColor colorWithRed:(152.0/255.0) green:(151.0/255.0) blue:(149.0/255.0) alpha:1]
#define LABELBORDERWIDTHAULATITULO2 1
#define LABELBORDERRADIUSAULATITULO2 0

#define HEADERAULATITULO2(x,y,w,h) [[CustomHeaderFooterAppearance alloc] initWithAppearance:LABELFRAMEAULATITULO2(x,y,w,h) labelBackgroundColor:LABELBACKGROUNDCOLORAULATITULO2 labelTextColor:LABELTEXTCOLORAULATITULO2 labelTextFont:LABELTEXTFONTAULATITULO2 labelTextAlignment:LABELTEXTALIGNMENTAULATITULO2 labelBorderColor:LABELBORDERCOLORAULATITULO2 labelBorderWidth:LABELBORDERWIDTHAULATITULO2 labelBorderRadius:LABELBORDERRADIUSAULATITULO2]

#define LABELFRAMEELMUNDO(x,y,w,h) CGRectMake(x, y, w, h)
#define LABELBACKGROUNDCOLORELMUNDO [UIColor colorWithRed:(152.0/255.0) green:(151.0/255.0) blue:(149.0/255.0) alpha:1]
#define LABELTEXTCOLORELMUNDO [UIColor blackColor]
#define LABELTEXTFONTELMUNDO [UIFont boldSystemFontOfSize:15]
#define LABELTEXTALIGNMENTELMUNDO NSTextAlignmentCenter
#define LABELBORDERCOLORELMUNDO [UIColor blackColor]
#define LABELBORDERWIDTHELMUNDO 0.8
#define LABELBORDERRADIUSELMUNDO 0

#define HEADERELMUNDO(x,y,w,h) [[CustomHeaderFooterAppearance alloc] initWithAppearance:LABELFRAMEELMUNDO(x,y,w,h) labelBackgroundColor:LABELBACKGROUNDCOLORELMUNDO labelTextColor:LABELTEXTCOLORELMUNDO labelTextFont:LABELTEXTFONTELMUNDO labelTextAlignment:LABELTEXTALIGNMENTELMUNDO labelBorderColor:LABELBORDERCOLORELMUNDO labelBorderWidth:LABELBORDERWIDTHELMUNDO labelBorderRadius:LABELBORDERRADIUSELMUNDO]




#define LABELFRAMEELMUNDO2(x,y,w,h) CGRectMake(x, y, w, h)
#define LABELBACKGROUNDCOLORELMUNDO2 [UIColor clearColor]
//#define LABELTEXTCOLORELMUNDO2 [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1]
#define LABELTEXTCOLORELMUNDO2 [UIColor blackColor]
#define LABELTEXTFONTELMUNDO2 [UIFont boldSystemFontOfSize:18]
#define LABELTEXTALIGNMENTELMUNDO2 NSTextAlignmentCenter
#define LABELBORDERCOLORELMUNDO2 [UIColor blackColor]
#define LABELBORDERWIDTHELMUNDO2 0
#define LABELBORDERRADIUSELMUNDO2 0

#define HEADERELMUNDO2(x,y,w,h) [[CustomHeaderFooterAppearance alloc] initWithAppearance:LABELFRAMEELMUNDO2(x,y,w,h) labelBackgroundColor:LABELBACKGROUNDCOLORELMUNDO2 labelTextColor:LABELTEXTCOLORELMUNDO2 labelTextFont:LABELTEXTFONTELMUNDO2 labelTextAlignment:LABELTEXTALIGNMENTELMUNDO2 labelBorderColor:LABELBORDERCOLORELMUNDO2 labelBorderWidth:LABELBORDERWIDTHELMUNDO2 labelBorderRadius:LABELBORDERRADIUSELMUNDO2]




/*#define HEADERAULATITULO1 [[CustomHeaderAppearance alloc] initWithAppearance:LABELFRAMEAULATITULO1(8,0,w,30) :LABELBACKGROUNDCOLORAULATITULO1 :LABELTEXTCOLORAULATITULO1 :LABELTEXTAULATITULO1 :LABELTEXTFONTAULATITULO1 :LABELTEXTALIGNMENTAULATITULO1 :LABELBORDERCOLORAULATITULO1 :LABELBORDERWIDTHAULATITULO1 :LABELBORDERRADIUSAULATITULO1]*/
/*
 @property (assign,nonatomic) CGRect labelFrame;
 @property (strong,nonatomic) UIColor * labelBackgroundColor;
 @property (strong,nonatomic) UIColor * labelTextColor;
 @property (strong,nonatomic) NSString * labelText;
 @property (strong,nonatomic) UIFont * labelTextFont;
 @property (assign,nonatomic) UITextAlignment labelTextAlignment;
 @property (strong,nonatomic) UIColor * labelBorderColor;
 @property (assign,nonatomic) double labelBorderWidth;
 @property (assign,nonatomic) double labelBorderRadius;*/


@class CustomHeaderFooterAppearance;
@interface FabricaHeaderFooterSecciones : NSObject

+(FabricaHeaderFooterSecciones *) getInstance;
-(UILabel *) getNewTitleLabelWithTitle: (NSString *) title appearance: (CustomHeaderFooterAppearance *) appearance;

@end
