//
//  LoadableViewController.m
//  FI UPM
//
//  Created by Lorenzo Villarroel on 14/05/13.
//  Copyright (c) 2013 Laboratorio Ingeniería del Software. All rights reserved.
//

#import "LoadableViewController.h"
#import "TVFramework.h"
#import "ASIHTTPRequest.h"

@interface LoadableViewController ()

@end

@implementation LoadableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self iniciarActivityIndicator];
    [self iniciarTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) iniciarActivityIndicator {
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    activityIndicator.color = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
    [activityIndicator startAnimating];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 0, 0)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 1;
    label.text = @"Cargando...";
    [label sizeToFit];
    
    CGRect frame = label.frame;
    frame.origin.x = (activityIndicator.frame.size.width/2) - (label.frame.size.width/2);
    label.frame = frame;
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:(65.0/255.0) green:(81.0/255.0) blue:(103.0/255.0) alpha:1];
    
    [activityIndicator addSubview:label];
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
}

-(void) stopActivityIndicator {
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
}

-(void) viewDidAppear:(BOOL)animated {
    if (self.customTableView.lastCellPressed) {
        [self.customTableView.lastCellPressed customDeselect];
    }
}

-(void) iniciarTableView {
    NSMutableArray *sections;
    SectionElement *sectionElement;
    NSMutableArray *cells;
    CGRect frameTableView = CGRectMake(0,
                                       0,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height);
    sections = [NSMutableArray array];
    cells = [NSMutableArray array];
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    
    self.customTableView = [[CustomTableViewController alloc] initWithFrame:frameTableView style:UITableViewStyleGrouped backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.customTableView.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.tableViewController = [[UITableViewController alloc] init];
    self.tableViewController.tableView = (UITableView *)self.customTableView;
    self.tableViewController.view.alpha = 0;
    [self addChildViewController:self.tableViewController];
    
    
    [self.view addSubview:self.tableViewController.view];
}

-(void) reloadTableViewWithSections: (NSMutableArray *) sections {
    self.customTableView.section.sections = sections;
    [self.customTableView reloadData];
    
    if (self.tableViewController.view.alpha != 1) {
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.tableViewController.view setAlpha:1];
        } completion:^(BOOL finished){
            
        }];
    }
}

//Este metodo se descarga una imagen de internet y la asigna a su imageView correspondiente
-(void) configureImageView: (NSMutableDictionary *) arguments {
    UIImageView * imageView = [arguments objectForKey:@"imageView"];
    NSString * url = [arguments objectForKey:@"url"];
    UIImage * imagen;
    NSURL * imageURL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:imageURL];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        NSData * imageData = [request responseData];
        imagen = [UIImage imageWithData:imageData];
        imageView.image = imagen;
    }
}

@end
