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
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self performSelectorOnMainThread:@selector(activateActivityIndicator) withObject:nil waitUntilDone:YES];
    [self performSelectorInBackground:@selector(downloadFullInfoFromMediaElementUser:) withObject:mediaElementUser];
    //NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadFullInfoFromMediaElementUser:) object:mediaElementUser];
    //[thread start];
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
            self.altoContenidoScrollView = 0;
            [self loadSegmentedControl];
            [self iniciarScrollView];
            
            [self createDetalleFromFullInfo:self.fullInfo];
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.altoContenidoScrollView + 20);
        }
        
    }
    
    [self stopActivityIndicator];
}

-(void) createDetalleFromFullInfo: (FullInfo *) fullInfo {
    [self createPosterSectionWithFullInfo:fullInfo];
    [self createPlotLabelWithText:fullInfo.plot];
    //UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1)];
    //view.backgroundColor = [UIColor redColor];
    //[self.view addSubview:view];
}

-(void) createPosterSectionWithFullInfo: (FullInfo *) fullInfo {
    int margenX = 5;
    int margenY = 10;
    UIImageView * poster = [[UIImageView alloc] initWithFrame:CGRectMake(margenX, margenY, 131.25, 195)];
    poster.layer.cornerRadius = 6.0f;
    poster.clipsToBounds = YES;
    NSString * urlImagen = fullInfo.poster.large;
    if (urlImagen) {
        NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
        [arguments setObject:poster forKey:@"imageView"];
        [arguments setObject:urlImagen forKey:@"url"];
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureImageView:) object:arguments];
        [thread start];
    }
    [self.scrollView addSubview:poster];
    
    int margenEtiquetas = 5;
    int margenContenidos = 5;
    int origenXEtiquetas = poster.frame.origin.x + poster.frame.size.width + margenEtiquetas;
    int widthEtiquetas = 60;
    int origenXContenidos = origenXEtiquetas + margenContenidos + widthEtiquetas;
    int widthContenidos = self.scrollView.frame.size.width - origenXContenidos - 5;
    
    int origenY = poster.frame.origin.y;
    int margenEntreEtiquetas = 13;
    if (fullInfo.year && ![fullInfo.year isEqualToString:@""]) {
        NSLog(@"/%@/",fullInfo.year);
        UILabel * labelEtiquetaAno = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaAno.backgroundColor = [UIColor clearColor];
        labelEtiquetaAno.font = [UIFont boldSystemFontOfSize:13];
        labelEtiquetaAno.text = @"Año";
        labelEtiquetaAno.numberOfLines = 0;
        labelEtiquetaAno.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaAno sizeToFit];
        
        UILabel * labelContenidoAno = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoAno.backgroundColor = [UIColor clearColor];
        labelContenidoAno.font = [UIFont systemFontOfSize:13];
        labelContenidoAno.text = fullInfo.year;
        labelContenidoAno.numberOfLines = 0;
        labelContenidoAno.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelContenidoAno sizeToFit];
        
        [self.scrollView addSubview:labelEtiquetaAno];
        [self.scrollView addSubview:labelContenidoAno];
        
        origenY += labelContenidoAno.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.country.count > 0) {
        UILabel * labelEtiquetaPais = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaPais.backgroundColor = [UIColor clearColor];
        labelEtiquetaPais.font = [UIFont boldSystemFontOfSize:13];
        labelEtiquetaPais.text = @"País";
        labelEtiquetaPais.numberOfLines = 0;
        labelEtiquetaPais.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaPais sizeToFit];
        
        UILabel * labelContenidoPais = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoPais.backgroundColor = [UIColor clearColor];
        labelContenidoPais.font = [UIFont systemFontOfSize:13];
        NSString * text;
        int i = 0;
        for (NSString * country in fullInfo.country) {
            if (i == 0) {
                text = [NSString stringWithFormat:@"%@",country];
                i++;
            } else {
                text = [NSString stringWithFormat:@"%@, %@",text,country];
            }            
        }
        labelContenidoPais.text = text;
        labelContenidoPais.numberOfLines = 0;
        labelContenidoPais.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelContenidoPais sizeToFit];
        [self.scrollView addSubview:labelEtiquetaPais];
        [self.scrollView addSubview:labelContenidoPais];
        origenY += labelContenidoPais.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.runtime) {
        UILabel * labelEtiquetaDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaDuracion.backgroundColor = [UIColor clearColor];
        labelEtiquetaDuracion.font = [UIFont boldSystemFontOfSize:13];
        labelEtiquetaDuracion.text = @"Duración";
        labelEtiquetaDuracion.numberOfLines = 0;
        labelEtiquetaDuracion.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaDuracion sizeToFit];
        
        UILabel * labelContenidoDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoDuracion.backgroundColor = [UIColor clearColor];
        labelContenidoDuracion.font = [UIFont systemFontOfSize:13];
        NSString * text = [NSString stringWithFormat:@"%@ minutos",fullInfo.runtime];
        labelContenidoDuracion.text = text;
        labelContenidoDuracion.numberOfLines = 0;
        labelContenidoDuracion.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelContenidoDuracion sizeToFit];
        [self.scrollView addSubview:labelEtiquetaDuracion];
        [self.scrollView addSubview:labelContenidoDuracion];
        origenY += labelContenidoDuracion.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.genres.count > 0) {
        UILabel * labelEtiquetaGenre = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaGenre.backgroundColor = [UIColor clearColor];
        labelEtiquetaGenre.font = [UIFont boldSystemFontOfSize:13];
        labelEtiquetaGenre.text = @"Género";
        labelEtiquetaGenre.numberOfLines = 0;
        labelEtiquetaGenre.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaGenre sizeToFit];
        
        UILabel * labelContenidoGenre = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoGenre.backgroundColor = [UIColor clearColor];
        labelContenidoGenre.font = [UIFont systemFontOfSize:13];
        NSString * text;
        int i = 0;
        for (NSString * country in fullInfo.genres) {
            if (i == 0) {
                text = [NSString stringWithFormat:@"%@",country];
                i++;
            } else {
                text = [NSString stringWithFormat:@"%@, %@",text,country];
            }
        }
        labelContenidoGenre.text = text;
        labelContenidoGenre.numberOfLines = 0;
        labelContenidoGenre.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelContenidoGenre sizeToFit];
        [self.scrollView addSubview:labelEtiquetaGenre];
        [self.scrollView addSubview:labelContenidoGenre];
        origenY += labelContenidoGenre.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.director.count > 0) {
        UILabel * labelEtiquetaDirector = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaDirector.backgroundColor = [UIColor clearColor];
        labelEtiquetaDirector.font = [UIFont boldSystemFontOfSize:13];
        labelEtiquetaDirector.text = @"Director";
        labelEtiquetaDirector.numberOfLines = 0;
        labelEtiquetaDirector.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaDirector sizeToFit];
        
        UILabel * labelEtiquetaDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelEtiquetaDuracion.backgroundColor = [UIColor clearColor];
        labelEtiquetaDuracion.font = [UIFont systemFontOfSize:13];
        Director * director = fullInfo.director[0];
        NSString * text = director.name;
        labelEtiquetaDuracion.text = text;
        labelEtiquetaDuracion.numberOfLines = 0;
        labelEtiquetaDuracion.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [labelEtiquetaDuracion sizeToFit];
        [self.scrollView addSubview:labelEtiquetaDirector];
        [self.scrollView addSubview:labelEtiquetaDuracion];
        origenY += labelEtiquetaDuracion.frame.size.height + margenEntreEtiquetas;
    }

    int altoSeccion = poster.frame.size.height;
    
    self.altoContenidoScrollView += altoSeccion + margenY;

}

-(void) createPlotLabelWithText: (NSString *) text {
    
    int margenX = 5;
    int margenYSinopsis = 10;
    int originYSinopsis = self.altoContenidoScrollView + margenYSinopsis;
    UILabel * sinopsisLabel = [[UILabel alloc] initWithFrame:CGRectMake(margenX, originYSinopsis, self.view.frame.size.width - 2*margenX, 0)];
    sinopsisLabel.backgroundColor = [UIColor clearColor];
    sinopsisLabel.font = [UIFont boldSystemFontOfSize:20];
    sinopsisLabel.text = @"Sinopsis";
    sinopsisLabel.numberOfLines = 0;
    sinopsisLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [sinopsisLabel sizeToFit];
    [self.scrollView addSubview:sinopsisLabel];
    
    int margenYPlot = 10;
    int originYPlotLabel = sinopsisLabel.frame.origin.y + sinopsisLabel.frame.size.height + margenYPlot;
    UILabel * plotLabel = [[UILabel alloc] initWithFrame:CGRectMake(margenX, originYPlotLabel, self.view.frame.size.width - 2*margenX, 0)];
    plotLabel.backgroundColor = [UIColor clearColor];
    plotLabel.font = [UIFont systemFontOfSize:14];
    plotLabel.text = text;
    plotLabel.numberOfLines = 0;
    plotLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [plotLabel sizeToFit];
    [self.scrollView addSubview:plotLabel];
    
    int altoSeccion = plotLabel.frame.size.height + sinopsisLabel.frame.size.height + margenYSinopsis + margenYPlot;
    self.altoContenidoScrollView += altoSeccion;
    
}

-(void) iniciarScrollView {
    int segmentedSize = self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                     segmentedSize,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height - segmentedSize)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = self.scrollView.frame.size;
    [self.view addSubview:self.scrollView];
}

-(void) loadSegmentedControl {
    int altoSegmented = 40;
    int margenSegmented = 5;
    self.segmentedControl =[[UISegmentedControl alloc]
                            initWithItems:[NSArray arrayWithObjects:
                                           @"Ficha",@"Capítulos", nil]];
    self.segmentedControl.frame = CGRectMake(margenSegmented, margenSegmented, self.view.frame.size.width - 2*margenSegmented, altoSegmented);
    
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
    [self.view addSubview:self.segmentedControl];
    
}

- (IBAction)manejadorSegmented:(UISegmentedControl *) sender {
    switch (sender.selectedSegmentIndex) {
        case 0:

            break;
        case 1:
            break;
        default:
            break;
    }
}

@end
