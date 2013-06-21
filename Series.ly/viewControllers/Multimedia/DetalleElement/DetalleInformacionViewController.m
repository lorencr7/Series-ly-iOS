//
//  DetalleInformacionViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel on 22/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "DetalleInformacionViewController.h"
#import "FullInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "Poster.h"
#import "Director.h"

@interface DetalleInformacionViewController ()

@end

@implementation DetalleInformacionViewController

- (id)initWithFrame: (CGRect) frame FullInfo: (FullInfo *) fullInfo {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.fullInfo = fullInfo;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) getData {
    [self createFichaFromFullInfo:self.fullInfo];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.altoContenidoScrollView + 20);
    return YES;
}

-(void) createFichaFromFullInfo: (FullInfo *) fullInfo {
    [self iniciarScrollView];
    [self createPosterSectionWithFullInfo:fullInfo];
    [self createPlotLabelWithText:fullInfo.plot];
}

-(void) createPosterSectionWithFullInfo: (FullInfo *) fullInfo {
    int margenX = 5;
    int margenY = 20;
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
    
    int margenEtiquetas = 15;
    int margenContenidos = 5;
    int origenXEtiquetas = poster.frame.origin.x + poster.frame.size.width + margenEtiquetas;
    int widthEtiquetas = 65;
    int origenXContenidos = origenXEtiquetas + margenContenidos + widthEtiquetas;
    int widthContenidos = self.scrollView.frame.size.width - origenXContenidos - 5;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        widthContenidos = 94;
        
    }
    int origenY = poster.frame.origin.y;
    int margenEntreEtiquetas = 13;
    //if (fullInfo.year && ![fullInfo.year isEqualToString:@""]) {
    if (fullInfo.year) {
        UILabel * labelEtiquetaAno = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaAno.backgroundColor = [UIColor clearColor];
        labelEtiquetaAno.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaAno.text = @"Año";
        labelEtiquetaAno.numberOfLines = 0;
        labelEtiquetaAno.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [labelEtiquetaAno sizeToFit];
        
        UILabel * labelContenidoAno = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoAno.backgroundColor = [UIColor clearColor];
        labelContenidoAno.font = [UIFont systemFontOfSize:13];
        //labelContenidoAno.text = fullInfo.year;
        labelContenidoAno.text = [NSString stringWithFormat:@"%d",fullInfo.year];
        labelContenidoAno.numberOfLines = 0;
        labelContenidoAno.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [labelContenidoAno sizeToFit];
        
        [self.scrollView addSubview:labelEtiquetaAno];
        [self.scrollView addSubview:labelContenidoAno];
        
        origenY += labelContenidoAno.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.country.count > 0) {
        UILabel * labelEtiquetaPais = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaPais.backgroundColor = [UIColor clearColor];
        labelEtiquetaPais.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaPais.text = @"País";
        labelEtiquetaPais.numberOfLines = 0;
        labelEtiquetaPais.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
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
        labelContenidoPais.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [labelContenidoPais sizeToFit];
        [self.scrollView addSubview:labelEtiquetaPais];
        [self.scrollView addSubview:labelContenidoPais];
        origenY += labelContenidoPais.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.runtime) {
        UILabel * labelEtiquetaDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaDuracion.backgroundColor = [UIColor clearColor];
        labelEtiquetaDuracion.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaDuracion.text = @"Duración";
        labelEtiquetaDuracion.numberOfLines = 0;
        labelEtiquetaDuracion.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [labelEtiquetaDuracion sizeToFit];
        
        UILabel * labelContenidoDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelContenidoDuracion.backgroundColor = [UIColor clearColor];
        labelContenidoDuracion.font = [UIFont systemFontOfSize:13];
        NSString * text = [NSString stringWithFormat:@"%@ minutos",fullInfo.runtime];
        labelContenidoDuracion.text = text;
        labelContenidoDuracion.numberOfLines = 0;
        labelContenidoDuracion.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [labelContenidoDuracion sizeToFit];
        [self.scrollView addSubview:labelEtiquetaDuracion];
        [self.scrollView addSubview:labelContenidoDuracion];
        origenY += labelContenidoDuracion.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.genres.count > 0) {
        UILabel * labelEtiquetaGenre = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaGenre.backgroundColor = [UIColor clearColor];
        labelEtiquetaGenre.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaGenre.text = @"Género";
        labelEtiquetaGenre.numberOfLines = 0;
        labelEtiquetaGenre.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
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
        labelContenidoGenre.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [labelContenidoGenre sizeToFit];
        [self.scrollView addSubview:labelEtiquetaGenre];
        [self.scrollView addSubview:labelContenidoGenre];
        origenY += labelContenidoGenre.frame.size.height + margenEntreEtiquetas;
    }
    
    if (fullInfo.director.count > 0) {
        UILabel * labelEtiquetaDirector = [[UILabel alloc] initWithFrame:CGRectMake(origenXEtiquetas, origenY, widthEtiquetas, 0)];
        labelEtiquetaDirector.backgroundColor = [UIColor clearColor];
        labelEtiquetaDirector.font = [UIFont boldSystemFontOfSize:14];
        labelEtiquetaDirector.text = @"Director";
        labelEtiquetaDirector.numberOfLines = 0;
        labelEtiquetaDirector.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [labelEtiquetaDirector sizeToFit];
        
        UILabel * labelEtiquetaDuracion = [[UILabel alloc] initWithFrame:CGRectMake(origenXContenidos, origenY, widthContenidos, 0)];
        labelEtiquetaDuracion.backgroundColor = [UIColor clearColor];
        labelEtiquetaDuracion.font = [UIFont systemFontOfSize:13];
        Director * director = fullInfo.director[0];
        NSString * text = director.name;
        labelEtiquetaDuracion.text = text;
        labelEtiquetaDuracion.numberOfLines = 0;
        labelEtiquetaDuracion.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [labelEtiquetaDuracion sizeToFit];
        [self.scrollView addSubview:labelEtiquetaDirector];
        [self.scrollView addSubview:labelEtiquetaDuracion];
        //origenY += labelEtiquetaDuracion.frame.size.height + margenEntreEtiquetas;
    }
    
    int altoSeccion = poster.frame.size.height;
    
    self.altoContenidoScrollView += altoSeccion + margenY;
    
}

-(void) createPlotLabelWithText: (NSString *) text {
    
    int margenX = 10;
    int margenYSinopsis = 20;
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
    int anchoPlotLabel= self.view.frame.size.width - 2*margenX;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        anchoPlotLabel = 300;
    }
    UILabel * plotLabel = [[UILabel alloc] initWithFrame:CGRectMake(margenX, originYPlotLabel, anchoPlotLabel, 0)];
    
    plotLabel.backgroundColor = [UIColor clearColor];
    plotLabel.font = [UIFont systemFontOfSize:14];
    plotLabel.text = text;
    plotLabel.numberOfLines = 0;
    plotLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [plotLabel sizeToFit];
    [self.scrollView addSubview:plotLabel];
    
    int altoSeccion = plotLabel.frame.size.height + sinopsisLabel.frame.size.height + margenYSinopsis + margenYPlot;
    self.altoContenidoScrollView += altoSeccion;
    
}

-(void) iniciarScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = self.scrollView.frame.size;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scrollView];
}


@end
