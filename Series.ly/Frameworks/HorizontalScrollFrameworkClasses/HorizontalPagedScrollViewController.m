//
//  ViewControllerRedactar.m
//  PruebaIphone
//
//  Created by Xavier Ferre on 08/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HorizontalPagedScrollViewController.h"
#import "Page.h"
#import <QuartzCore/QuartzCore.h>


@interface HorizontalPagedScrollViewController ()
-(void) configureModeStaticButtonsWidth:(double) buttonWidth;
-(void) createSelectedModeStaticWithWidth: (double) width;
-(UIButton *) createDefaultButton: (NSString*) title width: (double) buttonWidth;
-(void) createButtonsWithWidth: (double) buttonWidth;
-(void) loadScroll;
-(void) loadData;
-(IBAction)handlerButtons:(UIButton *)sender;
-(void)moveImage:(UIView *)image duration:(NSTimeInterval)duration curve:(int)curve x:(CGFloat)x y:(CGFloat)y;
@end


@implementation HorizontalPagedScrollViewController

@synthesize pages = _pages;
@synthesize buttons = _buttons;
@synthesize scrollView = _scrollView;
@synthesize buttonHeight = _buttonHeight;
@synthesize positionTop = _positionTop;
@synthesize rootViewController = _rootViewController;



- (id)initWithFrame: (CGRect) frame Pages: (NSArray *) pages ButtonHeight: (int) buttonHeight PositionTop: (BOOL) positionTop selectionIndicator: (HPSelectionIndicator) selectionIndicator {
    self = [super init];
    if (self) {
        self.view = [[UIView alloc] initWithFrame:frame];
        self.pages = pages;
        self.buttonHeight = buttonHeight;
        self.positionTop = positionTop;
        self.selectionIndicator = selectionIndicator;
        [self loadData];
    }
    return self;
}

- (id)initWithFrame: (CGRect) frame Pages: (NSArray *) pages ButtonHeight: (int) buttonHeight PositionTop: (BOOL) positionTop RootViewController: (UIViewController*) rootViewController selectionIndicator: (HPSelectionIndicator) selectionIndicator {
    self = [super init];
    if (self) {
        self.view = [[UIView alloc] initWithFrame:frame];
        self.pages = pages;
        self.buttonHeight = buttonHeight;
        self.positionTop = positionTop;
        self.rootViewController = rootViewController;
        self.selectionIndicator = selectionIndicator;
        [self loadData];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setButtons:nil];
    [self setPages:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) viewWillAppear:(BOOL)animated {
    
}


/*******************************************************************************
 Funciones desarrolladas por nosotros
 ******************************************************************************/



-(void) configureModeStaticButtonsWidth:(double) buttonWidth {//Configura el frame de todos los botones y le añade el target
    UIButton * button;
    for (int i = 0; i < self.buttons.count; i++) {
        button = [self.buttons objectAtIndex:i];
        double originYButton;
        if (self.positionTop) {
            originYButton = 0;
        } else {
            originYButton =  self.scrollView.frame.size.height;
        }
        button.frame = CGRectMake(buttonWidth*i, originYButton, buttonWidth, self.buttonHeight);
        [button addTarget:self action:@selector(handlerButtons:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
-(void) createSelectedModeShadowWithWidth:(double) width {
    double heightSelected = self.buttonHeight + 4;
    double originYSelected;
    if (self.positionTop) {
        originYSelected = 3;
    } else {
        originYSelected =  self.scrollView.frame.size.height -3 ;
    }
    self.selected = [[UILabel alloc] initWithFrame:CGRectMake(0, originYSelected, width, heightSelected)];
    //self.selected.backgroundColor = [UIColor colorWithRed:(151/255.0) green:(182/255.0) blue:(201/255.0) alpha:1];
    self.selected.backgroundColor =  [UIColor colorWithRed:(213/255.0) green:(216/255.0) blue:(217/255.0) alpha:1.0];
    self.selected.layer.cornerRadius = 8;
    [self.view addSubview:self.selected];
}

-(void) createSelectedModeStaticWithWidth: (double) width {//crea la barra que muestra que elemento esta seleccionado y las barras separadoras
    double heightSelected = self.buttonHeight/8;
    double heightBarUnderSelected = self.buttonHeight/20;
    double originYSelected;
    double originYUnderSelected;
    double originYLanes;
    if (self.positionTop) {
        originYSelected = self.buttonHeight-heightSelected-heightBarUnderSelected;
        originYUnderSelected = self.buttonHeight-heightBarUnderSelected;
        originYLanes = self.buttonHeight*0.2;
    } else {
        originYSelected =  self.scrollView.frame.size.height ;//+ self.buttonHeight-heightSelected-heightBarUnderSelected;
        originYUnderSelected = self.scrollView.frame.size.height;// + self.buttonHeight-heightBarUnderSelected;
        originYLanes = self.scrollView.frame.size.height + self.buttonHeight*0.2;
    }
    self.selected = [[UILabel alloc] initWithFrame:CGRectMake(0, originYSelected, width, heightSelected)];
    self.selected.backgroundColor = [UIColor colorWithRed:(0/255.f) green:(153/255.f) blue:(204/255.f) alpha:1.0];
    [self.view addSubview:self.selected];
    
    UILabel * barUnderSelected = [[UILabel alloc] initWithFrame:CGRectMake(0, originYUnderSelected, self.view.frame.size.width, heightBarUnderSelected)];
    barUnderSelected.backgroundColor = [UIColor colorWithRed:(0/255.f) green:(153/255.f) blue:(204/255.f) alpha:1.0];
    if (width < self.view.frame.size.width) {
        for (int i = 1; i < self.buttons.count; i++) {
            UIView * lane = [[UIView alloc] initWithFrame:CGRectMake((i*width)-1, originYLanes, 1, self.buttonHeight*0.6)];
            lane.backgroundColor = [UIColor colorWithRed:(88.0/255.0) green:(88.0/255.0) blue:(88.0/255.0) alpha:1];
            [self.view addSubview:lane];
        }
    }
    [self.view addSubview:barUnderSelected];
}


-(UIButton *) createDefaultButton: (NSString*) title width: (double) buttonWidth {
    UILabel * label;
    UIColor * backgroundColor = [UIColor blackColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button becomeFirstResponder];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, self.buttonHeight)];
    label.backgroundColor = backgroundColor;
    label.textColor = [UIColor whiteColor];
    //label.textColor = [UIColor colorWithRed:(0/255.f) green:(153/255.f) blue:(204/255.f) alpha:1.0];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [button addSubview:label];
    
    return button;
}

-(void) createButtonsWithWidth: (double) buttonWidth {
    int i = 0;
    self.buttons = [NSMutableArray array];
    
    for (Page *page in self.pages) {//creamos un boton por cada pagina. El texto del boton sera el title de la pagina
        if (page.button) {//Si la pagina tiene un boton, ponemos ese
            [self.buttons addObject:page.button];
        } else {//Si la pagina no tiene un boton, creamos uno por defecto
            [self.buttons addObject:[self createDefaultButton:page.title width:buttonWidth]];
        }
        
        
        [page loadData];
        CGRect pageFrame = page.view.frame;
        pageFrame.origin.x = self.scrollView.frame.size.width*i;
        page.view.frame = pageFrame;
        [self.scrollView addSubview:page.view];
        i++;
    }
    Page * pageOne = [self.pages objectAtIndex:0];
    self.rootViewController.title = pageOne.title;
    
}


/*******************************************************************************
 loadData
 ******************************************************************************/

-(void) loadData {
    double buttonWidth = 0;
    self.view.backgroundColor = [UIColor clearColor];
    if (self.buttonHeight == 0) {//Si no hay altura de botones predefinida, le ponemos una por defecto
        self.buttonHeight = 55;
    }
    if (self.pages.count == 0) {
        return;
    } else {
        [self loadScroll];
        buttonWidth = self.view.frame.size.width/self.pages.count;
        if (self.selectionIndicator == HPSelectionIndicatorAndroid) {
            [self createButtonsWithWidth:buttonWidth];//creamos los botones
            [self configureModeStaticButtonsWidth:buttonWidth];
            [self createSelectedModeStaticWithWidth:buttonWidth];
            [self.view addSubview:self.scrollView];
        } else if (self.selectionIndicator == HPSelectionIndicatorShadow) {
            [self createSelectedModeShadowWithWidth:buttonWidth];
            [self createButtonsWithWidth:buttonWidth];//creamos los botones
            [self configureModeStaticButtonsWidth:buttonWidth];
            [self.view addSubview:self.scrollView];
        }
        
    }
}

/*******************************************************************************
 Scroll
 ******************************************************************************/

/* Iniciamos el contenido del Scroll*/
-(void) loadScroll {
    double contentSizeWidth;
    double originYScroll;
    if (self.positionTop) {
        originYScroll = self.buttonHeight;
        //originYScroll = 30;
    } else {
        originYScroll = 0;
    }
    ////NSLog(@"%.2f",self.view.frame.size.height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, originYScroll, self.view.frame.size.width, self.view.frame.size.height - self.buttonHeight)];
    
    //self.scrollView.backgroundColor = [UIColor colorWithRed:(151/255.0) green:(182/255.0) blue:(201/255.0) alpha:1];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    // Ponemos el tamaño del contenido del scroll en funcion de los apartados
    
    contentSizeWidth = self.scrollView.frame.size.width*[self.pages count];
    
    self.scrollView.contentSize = CGSizeMake(contentSizeWidth, self.scrollView.frame.size.height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    double desplazamiento = scrollView.contentOffset.x - cambioContentOffset;
    cambioContentOffset = scrollView.contentOffset.x;
    
    mover += ((desplazamiento * self.selected.frame.size.width) / self.scrollView.frame.size.width);
    [self moveImage:self.selected duration:0.1 curve:UIViewAnimationCurveLinear x:mover y:0.0];
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    ////NSLog(@"%.2f,%.2f",cambioContentOffset,self.view.frame.size.width);
    int i = cambioContentOffset/self.view.frame.size.width;
    Page * page = [self.pages objectAtIndex:i];
    self.rootViewController.title = page.title;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToPage" object:page.title];
}


/*******************************************************************************
 TabBar
 ******************************************************************************/



- (IBAction)handlerButtons:(UIButton *)sender {
    int i = 0;
    for (UIButton * button in self.buttons) {
        if (button == sender) {
            break;
        }
        i++;
    }
    Page * page = [self.pages objectAtIndex:i];
    self.rootViewController.title = page.title;
    [self.scrollView setContentOffset: CGPointMake(self.scrollView.frame.size.width*i, 0) animated:YES];
    lastContentOffset = self.scrollView.frame.size.width*i;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tabBarButtonPressed" object:page.title];
}


- (void)moveImage:(UIView *)image duration:(NSTimeInterval)duration curve:(int)curve x:(CGFloat)x y:(CGFloat)y {
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
    
}

@end
