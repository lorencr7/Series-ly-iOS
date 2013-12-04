//
//  LoadableWithSegmentedControlViewController.m
//  Test Loadable Classes
//
//  Created by Lorenzo Villarroel Pérez on 23/06/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableWithSegmentedControlViewController.h"

@interface LoadableWithSegmentedControlViewController ()

@end

@implementation LoadableWithSegmentedControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = self.frame;
    //[self loadSegmentedControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) getData {
    //sleep(3);
    BOOL hayData = NO;
    if (!self.segmentedControl) {
        [self performSelectorOnMainThread:@selector(loadSegmentedControl) withObject:nil waitUntilDone:YES];
    }
    hayData = [self createTabs];
    if (hayData) {
        [self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:YES];
    }
    return hayData;
}

-(BOOL) createTabs {
    return NO;
}

-(void) loadSegmentedControl {
    int alto = 35;
    int margen = 5;
    
    self.segmentedControl =[[UISegmentedControl alloc] initWithItems:self.opcionesSegmented];
    int maxWidth = 444;
    int widthSegmented = self.view.frame.size.width > maxWidth ? maxWidth : self.view.frame.size.width;
    widthSegmented -= 2*margen;
    int origenXSegmented = self.view.frame.size.width/2 - widthSegmented/2;
    self.segmentedControl.frame = CGRectMake(origenXSegmented, margen+5, widthSegmented, alto);
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // Ponemos el manejador
    [self.segmentedControl   addTarget:self
                                action:@selector(manejadorSegmented:)
                      forControlEvents:UIControlEventValueChanged];
    
    /*//self.segmentedControl.tintColor = SEGMENTEDCONTROLTINTCOLOR;

    [self.segmentedControl setTitleTextAttributes:  @{NSForegroundColorAttributeName: SEGMENTEDCONTROLUNSELECTEDFONTCOLOR,
                                                      //NSBackgroundColorAttributeName: SEGMENTEDCONTROLUNSELECTEDFONTSHADOWCOLOR,
                                                      NSFontAttributeName: SEGMENTEDCONTROLUNSELECTEDFONT}
                                         forState:UIControlStateNormal];
    
    [self.segmentedControl setTitleTextAttributes:  @{NSForegroundColorAttributeName: SEGMENTEDCONTROLSELECTEDFONTCOLOR,
                                                      //NSBackgroundColorAttributeName: SEGMENTEDCONTROLSELECTEDFONTSHADOWCOLOR,
                                                      NSFontAttributeName: SEGMENTEDCONTROLSELECTEDFONT}
                                         forState:UIControlStateSelected];*/
    
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.segmentedControl];
    
}

- (IBAction)manejadorSegmented:(UISegmentedControl *) sender {
    [self.viewControllerPresented.view removeFromSuperview];
    UIViewController * viewController = self.viewControllers[sender.selectedSegmentIndex];
    [self.view addSubview:viewController.view];
    self.viewControllerPresented = viewController;
}

@end
