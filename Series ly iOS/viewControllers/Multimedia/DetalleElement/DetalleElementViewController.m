//
//  DetalleElementViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DetalleElementViewController.h"
#import "FullInfo.h"
#import "ManejadorServicioWebSeriesly.h"
#import "UserCredentials.h"
#import "MediaElementUser.h"
#import "Poster.h"
#import <QuartzCore/QuartzCore.h>
#import "Director.h"
#import "TVFramework.h"
#import "SeasonsEpisodes.h"
#import "Season.h"
#import "Episode.h"
#import "VerLinksViewController.h"
#import "CustomCellMultimediaListadoCapitulos.h"
#import "Pending.h"
#import "DetalleInformacionViewController.h"
#import "DetalleEnlacesViewController.h"


@interface DetalleElementViewController ()

@end

@implementation DetalleElementViewController

- (id)initWithFrame: (CGRect) frame MediaElementUser: (MediaElementUser *) mediaElementUser {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.mediaElementUser = mediaElementUser;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
    
    //NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadFullInfoFromMediaElementUser:) object:self.mediaElementUser];
    //[thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadInfoFromMediaElementUser: (MediaElementUser *) mediaElementUser {
    self.mediaElementUser = mediaElementUser;
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self performSelectorOnMainThread:@selector(activateActivityIndicator) withObject:nil waitUntilDone:YES];
    [self performSelectorInBackground:@selector(downloadFullInfoFromMediaElementUser:) withObject:mediaElementUser];
}

-(void) getData {
    [self downloadFullInfoFromMediaElementUser:self.mediaElementUser];
}

-(void) downloadFullInfoFromMediaElementUser: (MediaElementUser *) mediaElementUser {
    [self.threads addObject:[NSThread currentThread]];
    
    if (mediaElementUser) {
        ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
        
        UserCredentials * userCredentials = [UserCredentials getInstance];
        
        self.fullInfo = [manejadorServicioWeb getMediaFullInfoWithRequest:nil
                                                             ProgressView:nil
                                                                AuthToken:userCredentials.authToken
                                                                UserToken:userCredentials.userToken
                                                                      Idm:mediaElementUser.idm
                                                                MediaType:mediaElementUser.mediaType];
        if (self.fullInfo) {
            [self performSelectorOnMainThread:@selector(createContent) withObject:nil waitUntilDone:YES];
        }
        
        
    }
    
    [self stopActivityIndicator];
}

-(void) createContent {
    CGRect elementsFrame;
    if (self.fullInfo.seasonsEpisodes) {
        [self loadSegmentedControl];
        int topViewSize = self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
        elementsFrame = CGRectMake(0,
                                  topViewSize,
                                  self.view.frame.size.width,
                                  self.view.frame.size.height - topViewSize);
        self.detalleInformacionViewController = [[DetalleInformacionViewController alloc] initWithFrame:elementsFrame FullInfo:self.fullInfo];
        
        self.detalleEnlacesViewController = [[DetalleEnlacesViewController alloc] initWithFrame:elementsFrame FullInfo:self.fullInfo MediaElementUser:self.mediaElementUser];
        [self addChildViewController:self.detalleEnlacesViewController];
    } else {
        [self loadButtonVerEnlaces];
        int topViewSize = self.buttonVerEnlaces.frame.origin.y + self.buttonVerEnlaces.frame.size.height;
        elementsFrame = CGRectMake(0,
                                   topViewSize,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height - topViewSize);
        self.detalleInformacionViewController = [[DetalleInformacionViewController alloc] initWithFrame:elementsFrame FullInfo:self.fullInfo];

    }
    [self addChildViewController:self.detalleInformacionViewController];
    [self.view addSubview:self.detalleInformacionViewController.view];
}


-(void) loadButtonVerEnlaces {
    self.buttonVerEnlaces = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    int alto = 40;
    int margen = 5;
    self.buttonVerEnlaces.frame = CGRectMake(margen, margen+5, self.view.frame.size.width - 2*margen, alto);
    [self.buttonVerEnlaces addTarget:self
                              action:@selector(manejadorButtonVerEnlaces:)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.buttonVerEnlaces setTitle:@"Ver enlaces" forState:UIControlStateNormal];
    self.buttonVerEnlaces.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.buttonVerEnlaces];
}

-(void) loadSegmentedControl {
    int alto = 35;
    int margen = 5;
    self.segmentedControl =[[UISegmentedControl alloc]
                            initWithItems:[NSArray arrayWithObjects:
                                           @"Ficha",@"Capítulos", nil]];
    self.segmentedControl.frame = CGRectMake(margen, margen+5, self.view.frame.size.width - 2*margen, alto);
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // Ponemos el manejador
    [self.segmentedControl   addTarget:self
                                action:@selector(manejadorSegmented:)
                      forControlEvents:UIControlEventValueChanged];
    
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.tintColor = [UIColor colorWithRed:(135/255.0) green:(174/255.0) blue:(232/255.0) alpha:1];
    
    
    [self.segmentedControl setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:
                                                     [UIColor blackColor],
                                                     UITextAttributeTextColor,
                                                     [UIColor colorWithRed:(140.0/255.0) green:(175.0/255.0) blue:(224.0/255.0) alpha:1.0],
                                                     UITextAttributeTextShadowColor,
                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                     UITextAttributeTextShadowOffset,
                                                     [UIFont boldSystemFontOfSize:12.5f],
                                                     UITextAttributeFont,
                                                     nil]  forState:UIControlStateNormal];
    
    [self.segmentedControl setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:
                                                     [UIColor whiteColor],
                                                     UITextAttributeTextColor,
                                                     [UIColor whiteColor],
                                                     UITextAttributeTextShadowColor,
                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                     UITextAttributeTextShadowOffset,
                                                     [UIFont systemFontOfSize:12.5f],
                                                     UITextAttributeFont,
                                                     nil]  forState:UIControlStateSelected];
    
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.segmentedControl];
    
}

- (IBAction)manejadorButtonVerEnlaces:(UIButton *) sender {
    Pending * pending = [[Pending alloc] init];
    CustomCellMultimediaListadoCapitulos * customCellMultimediaListadoCapitulos = [[CustomCellMultimediaListadoCapitulos alloc] initWithMediaElementUser:self.mediaElementUser Pending:pending];
    [customCellMultimediaListadoCapitulos executeAction:self];
}

- (IBAction)manejadorSegmented:(UISegmentedControl *) sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.view addSubview: self.detalleInformacionViewController.view];
            [self.detalleEnlacesViewController.view removeFromSuperview];
            break;
        case 1:
            [self.view addSubview: self.detalleEnlacesViewController.view];
            [self.detalleInformacionViewController.view removeFromSuperview];
            break;
        default:
            break;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    int topViewSize = 0;
    if (self.segmentedControl) {
        topViewSize += self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
    }
    if (self.buttonVerEnlaces) {
        topViewSize += self.buttonVerEnlaces.frame.origin.y + self.buttonVerEnlaces.frame.size.height;
    }
    CGRect frame = CGRectMake(0,
                              topViewSize,
                              self.view.frame.size.width,
                              self.view.frame.size.height - topViewSize);
    self.detalleEnlacesViewController.view.frame = frame;
    self.detalleInformacionViewController.view.frame = frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            self.detalleInformacionViewController.scrollView.contentSize = CGSizeMake(frame.size.width, self.detalleInformacionViewController.scrollView.contentSize.height);
            
        } else {
            
        }
    }
}

-(void) cancelThreadsAndRequests {
    [super cancelThreadsAndRequests];
    [self.detalleEnlacesViewController cancelThreadsAndRequests];
    [self.detalleInformacionViewController cancelThreadsAndRequests];
}

@end
