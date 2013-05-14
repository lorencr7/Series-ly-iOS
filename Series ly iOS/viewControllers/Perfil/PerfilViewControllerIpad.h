//
//  PerfilViewControllerIpad.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 26/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "PerfilViewController.h"
#import <iAd/iAd.h>

@interface PerfilViewControllerIpad : PerfilViewController <ADInterstitialAdDelegate>

@property (strong, nonatomic) ListadoCapitulosPendientesViewController * listadoCapitulosPendientesViewController;
@property (strong, nonatomic) ADInterstitialAd * interstitial;


@end
