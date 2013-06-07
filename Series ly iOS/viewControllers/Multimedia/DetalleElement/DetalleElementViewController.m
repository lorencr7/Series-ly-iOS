//
//  DetalleElementViewController.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 15/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellMultimediaListadoCapitulos.h"
#import "DetalleElementViewController.h"
#import "DetalleEnlacesViewController.h"
#import "DetalleInformacionViewController.h"
#import "FullInfo.h"
#import "ManejadorServicioWebSeriesly.h"
#import "MediaElement.h"
#import "Pending.h"
#import "UserCredentials.h"
#import "TVFramework.h"
#import "ShareHeaders.h"
#import "CustomCellCompartirTwitter.h"
#import "CustomCellCompartirFacebook.h"

@interface DetalleElementViewController ()

@end

@implementation DetalleElementViewController

static NSString * kCompartirEnTwitter = @"Compartir en Twitter";
static NSString * kCompartirEnFacebook = @"Compartir en Facebook";
static NSString * kDejarDeSeguir = @"Dejar de seguir";
static NSString * kMarcarComoSiguiendo = @"Marcar como siguiendo";
static NSString * kMarcarComoPendiente = @"Marcar como pendiente";
static NSString * kMarcarComoVista = @"Marcar como vista";
static NSString * kCancelar = @"Cancelar";
static NSString * kMarcarComoFavorita = @"Marcar como favorita";

- (id)initWithFrame: (CGRect) frame MediaElement: (MediaElement *) mediaElement {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.mediaElement = mediaElement;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = self.frame;
    [super viewDidLoad];
    self.buttonCompartir = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                         target:self
                                                                         action:@selector(handlerAction:)];
	self.navigationItem.rightBarButtonItem = self.buttonCompartir;
    
    self.parentViewController.navigationItem.rightBarButtonItems = self.navigationItem.rightBarButtonItems;
    
    //self.navigationItem.rightBarButtonItems = self.detalleElementViewController.navigationItem.rightBarButtonItems;
    
    //NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadFullInfoFromMediaElement:) object:self.mediaElementUser];
    //[thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadInfoFromMediaElement: (MediaElement *) mediaElementUser {
    self.mediaElement = mediaElementUser;
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self performSelectorOnMainThread:@selector(activateActivityIndicator) withObject:nil waitUntilDone:YES];
    [self performSelectorInBackground:@selector(downloadFullInfoFromMediaElement:) withObject:mediaElementUser];
}

-(void) getData {
    [self downloadFullInfoFromMediaElement:self.mediaElement];
}

-(void) downloadFullInfoFromMediaElement: (MediaElement *) mediaElementUser {
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
        self.esSerie = YES;
        [self loadSegmentedControl];
        int topViewSize = self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
        elementsFrame = CGRectMake(0,
                                   topViewSize,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height - topViewSize);
        self.detalleInformacionViewController = [[DetalleInformacionViewController alloc] initWithFrame:elementsFrame FullInfo:self.fullInfo];
        
        self.detalleEnlacesViewController = [[DetalleEnlacesViewController alloc] initWithFrame:elementsFrame FullInfo:self.fullInfo MediaElement:self.mediaElement];
        [self addChildViewController:self.detalleEnlacesViewController];
    } else {
        self.esSerie = NO;
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
    
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.segmentedControl];
    
}

- (IBAction)manejadorButtonVerEnlaces:(UIButton *) sender {
    Pending * pending = [[Pending alloc] init];
    CustomCellMultimediaListadoCapitulos * customCellMultimediaListadoCapitulos = [[CustomCellMultimediaListadoCapitulos alloc] initWithMediaElement:self.mediaElement Pending:pending];
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

-(void)handlerAction:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIActionSheet *confirmacion = [[UIActionSheet alloc] init];
        int numeroDeBotones = 6;
        [confirmacion addButtonWithTitle:kCompartirEnTwitter];
        [confirmacion addButtonWithTitle:kCompartirEnFacebook];
        if (self.mediaElement.status) {
            [confirmacion addButtonWithTitle:kDejarDeSeguir];
            numeroDeBotones ++;
        }
        if (self.esSerie) {
            [confirmacion addButtonWithTitle:kMarcarComoSiguiendo];
            [confirmacion addButtonWithTitle:kMarcarComoPendiente];
            [confirmacion addButtonWithTitle:kMarcarComoVista];
        } else {
            [confirmacion addButtonWithTitle:kMarcarComoVista];
            [confirmacion addButtonWithTitle:kMarcarComoFavorita];
            [confirmacion addButtonWithTitle:kMarcarComoPendiente];
        }
        
        
        [confirmacion addButtonWithTitle:kCancelar];
        confirmacion.delegate = self;
        [confirmacion setCancelButtonIndex:numeroDeBotones - 1];
        /*UIActionSheet *confirmacion = [[UIActionSheet alloc] initWithTitle: @"Compartir"
                                                                  delegate:self
                                                         cancelButtonTitle: @"Cancelar"
                                                    destructiveButtonTitle: nil
                                                         otherButtonTitles: @"Compartir en Twitter",@"Compartir en Facebook", nil];*/
        //[confirmacion showInView:self.view];
        [confirmacion showFromBarButtonItem:self.buttonCompartir animated:YES];
        
    } else {
        if ([self.popover isPopoverVisible]) {
            [self.popover dismissPopoverAnimated:YES];
        } else {
            /*SectionElement * sectionElement = [self getSectionElementForPopoverTableView];
            NSMutableArray * sections = [NSMutableArray arrayWithObject:sectionElement];
            int popoverHeight = sectionElement.cells.count*60 + sectionElement.cells.count*10;
            self.tableViewControllerPopover.contentSizeForViewInPopover = CGSizeMake(250,  popoverHeight);
            self.tableViewPopover.section.sections = sections;
            [self.tableViewPopover reloadData];*/
            [self iniciarTableViewPopover];
            self.popover = [[UIPopoverController alloc] initWithContentViewController:self.tableViewControllerPopover];
            [self.popover presentPopoverFromBarButtonItem:self.buttonCompartir
                                 permittedArrowDirections:UIPopoverArrowDirectionAny
                                                 animated:YES];
        }
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    int newStatus = -5;
    NSString * buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:kCompartirEnTwitter]) {
        NSString * postToTwitterText = [NSString stringWithFormat:@"Estoy viendo %@ en Series.ly",self.mediaElement.name];
        [[ShareTwitter getInstance] postToTwitterText:postToTwitterText foto:nil urlString:self.mediaElement.url viewController:self];
    } else if ([buttonTitle isEqualToString:kCompartirEnFacebook]) {
        NSString * postToFacebookText = [NSString stringWithFormat:@"Estoy viendo %@ en Series.ly",self.mediaElement.name];
        [[ShareFacebook getInstance] postToFacebookText:postToFacebookText foto:nil urlString:self.mediaElement.url viewController:self];
    } else if ([buttonTitle isEqualToString:kDejarDeSeguir]) {
        newStatus = 0;
    } else if ([buttonTitle isEqualToString:kMarcarComoSiguiendo]) {
        if (self.esSerie) {
            newStatus = 1;
        }
    } else if ([buttonTitle isEqualToString:kMarcarComoPendiente]) {
        if (self.esSerie) {
            newStatus = 2;
        } else {
            newStatus = 3;
        }
    } else if ([buttonTitle isEqualToString:kMarcarComoVista]) {
        if (self.esSerie) {
            newStatus = 3;
        } else {
            newStatus = 1;
        }
    } else if ([buttonTitle isEqualToString:kMarcarComoFavorita]) {
            newStatus = 2;
    }
    if (newStatus != -5) {
        UserCredentials * userCredentials = [UserCredentials getInstance];
        ManejadorServicioWebSeriesly * manejadorServicioWeb = [ManejadorServicioWebSeriesly getInstance];
        [manejadorServicioWeb updateMediaStatusWithAuthToken:userCredentials.authToken UserToken:userCredentials.userToken MediaElement:self.mediaElement Status:newStatus];
    }
    
    
}

-(CustomCell *) createCellPopover: (CustomCell *) customCell ImageName: (NSString *) imageName CellText: (NSString *) cellText {
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       250,
                                                                       0)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    int altoCelda = 60;
    UIImageView * imageView;
    if (imageName) {
        UIImage * imagen = [UIImage imageNamed:imageName];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        
        imageView.image = imagen;
        CGRect imageFrame = imageView.frame;
        imageFrame.size = imagen.size;
        imageView.frame = imageFrame;
    }
    
    
    UILabel * label = [[UILabel alloc] init];
    label.text = cellText;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    
    CGRect frame = label.frame;
    frame.origin.y = altoCelda/2 - label.frame.size.height/2;
    frame.origin.x = imageView.frame.origin.x + imageView.frame.size.width + 10;
    label.frame = frame;
    
    //altoCelda = imageView.frame.origin.y + imageView.frame.size.height + 15;
    //NSLog(@"%d",altoCelda);
    
    [backgroundView addSubview:imageView];
    [backgroundView addSubview:label];
    
    
    
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAPOPOVERCOMPARTIR(backgroundView, altoCelda) cellText:nil selectionType:YES customCell:customCell];
    return customCell;
}

-(SectionElement *) getSectionElementForPopoverTableView {
    SectionElement *sectionElement;
    NSMutableArray *cells;
    
    cells = [NSMutableArray array];
    
    CustomCellCompartirTwitter *customCellTwitter = [[CustomCellCompartirTwitter alloc] initWithMediaElement:self.mediaElement];
    customCellTwitter = (CustomCellCompartirTwitter*)[self createCellPopover:customCellTwitter ImageName:@"twitterLogo50x50.png" CellText:kCompartirEnTwitter];
    [cells addObject:customCellTwitter];
    
    CustomCellCompartirFacebook *customCellFacebook = [[CustomCellCompartirFacebook alloc] initWithMediaElement:self.mediaElement];
    customCellFacebook = (CustomCellCompartirFacebook*)[self createCellPopover:customCellFacebook ImageName:@"facebookLogo50x50.png" CellText:kCompartirEnFacebook];
    [cells addObject:customCellFacebook];
    
    if (self.mediaElement.status) {
        CustomCell *customCellNoSeguir = [[CustomCell alloc] init];
        customCellNoSeguir = [self createCellPopover:customCellNoSeguir ImageName:nil CellText:kDejarDeSeguir];
        [cells addObject:customCellNoSeguir];
    }
    
    if (self.esSerie) {
        CustomCell *customCellSeguir = [[CustomCell alloc] init];
        customCellSeguir = [self createCellPopover:customCellSeguir ImageName:nil CellText:kMarcarComoSiguiendo];
        [cells addObject:customCellSeguir];
        
        CustomCell *customCellPendiente = [[CustomCell alloc] init];
        customCellPendiente = [self createCellPopover:customCellPendiente ImageName:nil CellText:kMarcarComoPendiente];
        [cells addObject:customCellPendiente];
        
        CustomCell *customCellVista = [[CustomCell alloc] init];
        customCellVista = [self createCellPopover:customCellVista ImageName:nil CellText:kMarcarComoVista];
        [cells addObject:customCellVista];
    } else {
        CustomCell *customCellVista = [[CustomCell alloc] init];
        customCellVista = [self createCellPopover:customCellVista ImageName:nil CellText:kMarcarComoVista];
        [cells addObject:customCellVista];
        
        CustomCell *customCellFavorita = [[CustomCell alloc] init];
        customCellFavorita = [self createCellPopover:customCellFavorita ImageName:nil CellText:kMarcarComoFavorita];
        [cells addObject:customCellFavorita];
        
        CustomCell *customCellPendiente = [[CustomCell alloc] init];
        customCellPendiente = [self createCellPopover:customCellPendiente ImageName:nil CellText:kMarcarComoPendiente];
        [cells addObject:customCellPendiente];
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    return sectionElement;
}

-(void) iniciarTableViewPopover {
    CGRect frameTableView = CGRectMake(0,
                                       0,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height);
    SectionElement *sectionElement = [self getSectionElementForPopoverTableView];
    NSMutableArray * sections = [NSMutableArray arrayWithObject:sectionElement];
    
    self.tableViewPopover = [[CustomTableViewController alloc] initWithFrame:frameTableView style:UITableViewStylePlain backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewPopover.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.tableViewControllerPopover = [[UITableViewController alloc] init];
    self.tableViewControllerPopover.tableView = (UITableView *)self.tableViewPopover;
    self.tableViewControllerPopover.view.alpha = 1;
    //int popoverHeight = sectionElement.cells.count*60 + sectionElement.cells.count*10;
    int popoverHeight = sectionElement.cells.count*69;
    self.tableViewControllerPopover.contentSizeForViewInPopover = CGSizeMake(250,  popoverHeight);
    //[self addChildViewController:self.tableViewControllerPopover];
    
    //[self.view addSubview:self.tableViewController.view];
}

@end
