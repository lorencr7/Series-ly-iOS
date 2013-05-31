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


@interface DetalleElementViewController ()

@end

@implementation DetalleElementViewController

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
        UIActionSheet *confirmacion = [[UIActionSheet alloc] initWithTitle: @"Compartir"
                                                                  delegate:self
                                                         cancelButtonTitle: @"Cancelar"
                                                    destructiveButtonTitle: nil
                                                         otherButtonTitles: @"Compartir en Twitter",@"Compartir en Facebook", nil];
        [confirmacion showInView:self.view];
        
    } else {
        [self iniciarTableViewPopover];
        self.popover = [[UIPopoverController alloc] initWithContentViewController:self.tableViewControllerPopover];
        [self.popover presentPopoverFromBarButtonItem:self.buttonCompartir
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0://descartar
            
            break;
        case 1: {//guardar
            break;
        }
        default:
            break;
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
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 0, 0)];
        
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


-(void) iniciarTableViewPopover {
    NSMutableArray *sections;
    SectionElement *sectionElement;
    NSMutableArray *cells;
    CGRect frameTableView = CGRectMake(0,
                                       0,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height);
    sections = [NSMutableArray array];
    cells = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        CustomCell *customCell = [[CustomCell alloc] init];
        customCell = [self createCellPopover:customCell ImageName:nil CellText:@"Compartir en Twitter"];
        //[[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAAULA cellText:@"hola" selectionType:YES customCell:customCell];
        [cells addObject:customCell];
        
    }
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    self.tableViewPopover = [[CustomTableViewController alloc] initWithFrame:frameTableView style:UITableViewStylePlain backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.tableViewPopover.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.tableViewControllerPopover = [[UITableViewController alloc] init];
    self.tableViewControllerPopover.tableView = (UITableView *)self.tableViewPopover;
    self.tableViewControllerPopover.view.alpha = 1;
    int popoverHeight = cells.count*60 + 40;
    self.tableViewControllerPopover.contentSizeForViewInPopover = CGSizeMake(250,  popoverHeight);
    //[self addChildViewController:self.tableViewControllerPopover];
    
    //[self.view addSubview:self.tableViewController.view];
}

@end
