//
//  LoadableViewController.m
//  FI UPM
//
//  Created by Lorenzo Villarroel on 14/05/13.
//  Copyright (c) 2013 Laboratorio Ingeniería del Software. All rights reserved.
//

#import "LoadableWithTableViewController.h"
#import "TVFramework.h"
#import "Reachability.h"

@interface LoadableWithTableViewController ()

@end

@implementation LoadableWithTableViewController

- (void)viewDidLoad {
    [self iniciarTableView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    
}

-(BOOL) getData {
    self.sourceData = [self getSourceData];
    if (self.sourceData) {
        [self performSelectorOnMainThread:@selector(getSectionsMainThread) withObject:nil waitUntilDone:YES];
        return YES;
    } else {
        return NO;
    }
    
}

-(void) createErrorMessage {
    NSMutableArray * sections = [self getErrorDescargaSections];
    [self reloadTableViewWithSectionsError:sections];
}

-(NSMutableArray *) getErrorDescargaSections {
    Reachability* internetReachable;
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    
    NSString * cellErrorText;
    
    if (internetStatus == NotReachable) {
        cellErrorText = self.mensajeSinConexion;
    } else {
        cellErrorText = self.mensajeErrorDescarga;
    }
    [internetReachable stopNotifier];
    
    NSMutableArray *sections;
    SectionElement *sectionElement;
    NSMutableArray *cells;
    sections = [NSMutableArray array];
    cells = [NSMutableArray array];
    
    
    
    CustomCell * customCell = [[CustomCell alloc] init];
    [[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAMENSAJEERROR cellText:cellErrorText selectionType:NO customCell:customCell];

    //[[FabricaCeldas getInstance] createNewCustomCellWithAppearance:APARIENCIAMENSAJEERROR cellText:@"" selectionType:YES customCell:customCell];
    [cells addObject:customCell];
    
    sectionElement = [[SectionElement alloc] initWithHeightHeader:0 labelHeader:nil heightFooter:0 labelFooter:nil cells:cells];
    [sections addObject:sectionElement];
    return sections;
}

-(void) getSectionsMainThread {
    NSMutableArray * sections = [self getSectionsFromSourceData:self.sourceData];
    [self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(reloadTableViewWithSections:) withObject:sections waitUntilDone:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    self.customTableView = [[CustomTableViewController alloc] initWithFrame:frameTableView style:UITableViewStylePlain backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
    self.customTableView.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.tableViewController = [[UITableViewController alloc] init];
    self.tableViewController.tableView = (UITableView *)self.customTableView;
    self.tableViewController.view.alpha = 1;
    [self addChildViewController:self.tableViewController];
    
    
    [self.view addSubview:self.tableViewController.view];
}

-(void) reloadTableViewWithSections: (NSMutableArray *) sections {
    self.customTableView.section.sections = sections;
    [self.customTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

    if (self.tableViewController.view.alpha != 1) {
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{

            [self.tableViewController.view setAlpha:1];
        } completion:^(BOOL finished){
            
        }];
    }
}

-(void) reloadTableViewWithSectionsError: (NSMutableArray *) sections {
    self.customTableView.section.sections = sections;
    [self.customTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    if (self.tableViewController.view.alpha != 1) {
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            [self.tableViewController.view setAlpha:1];
        } completion:^(BOOL finished){
            
        }];
    }
}



-(NSMutableArray *) getSourceData {
    return nil;
}

-(NSMutableArray *) getSectionsFromSourceData: (NSMutableArray *) sourceData {
    
    return nil;
}



@end
