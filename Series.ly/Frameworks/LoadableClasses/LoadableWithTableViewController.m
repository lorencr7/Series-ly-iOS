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

- (id)initWithFrame:(CGRect)frame MultipleSelection: (BOOL) multipleSelection editMode:(BOOL) editMode {
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleSelection = multipleSelection;
        self.editMode = editMode;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleSelection = NO;
        self.editMode = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.customTableView || !self.customTableViewEdit) {
        //[self performSelectorOnMainThread:@selector(iniciarTableView) withObject:nil waitUntilDone:YES];
        [self iniciarTableView];
    }
}

-(BOOL) getData {
    BOOL hayData = NO;
    
    NSMutableArray * previousSourceData = self.sourceData;
    self.sourceData = [self getSourceData];
    if (self.sourceData) {
        if (![previousSourceData isEqualToArray:self.sourceData]) {
            [self performSelectorOnMainThread:@selector(getSectionsMainThread) withObject:nil waitUntilDone:YES];
            hayData = YES;
        }
    }
    return hayData;
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
    [self stopActivityIndicator];
    [self reloadTableViewWithSections:sections];
    //[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:YES];
    //[self performSelectorOnMainThread:@selector(reloadTableViewWithSections:) withObject:sections waitUntilDone:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) viewDidAppear:(BOOL)animated {
    if (self.customTableView.lastCellPressed) {
        [self.customTableView.lastCellPressed customDeselect];
    }
    if (self.customTableViewEdit.lastCellPressed) {
        [self.customTableViewEdit.lastCellPressed customDeselect];
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
    
    self.tableViewController = [[UITableViewController alloc] init];
    self.tableViewController.view.alpha = 1;
    
    if (self.editMode) {
        self.customTableViewEdit = [[CustomTableViewEditController alloc] initWithFrame:frameTableView style:UITableViewStylePlain backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
        self.customTableViewEdit.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.customTableViewEdit.allowsMultipleSelection = self.multipleSelection;
        
        self.tableViewController.tableView = (UITableView *)self.customTableViewEdit;
    } else {
        self.customTableView = [[CustomTableViewController alloc] initWithFrame:frameTableView style:UITableViewStylePlain backgroundView:nil backgroundColor:[UIColor clearColor] sections:sections viewController:self title:nil];
        self.customTableView.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.customTableView.allowsMultipleSelection = self.multipleSelection;
        
        self.tableViewController.tableView = (UITableView *)self.customTableView;
    }
    self.tableViewController.tableView.separatorColor = [UIColor whiteColor];
    //self.tableViewController.tableView.acceso
    
    [self addChildViewController:self.tableViewController];
    
    [self.view addSubview:self.tableViewController.view];
}

-(void) reloadTableViewWithSections: (NSMutableArray *) sections {
    if (self.editMode) {
        self.customTableViewEdit.section.sections = sections;
        [self.customTableViewEdit performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    } else {
        self.customTableView.section.sections = sections;
        [self.customTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
    
    if (self.tableViewController.view.alpha != 1) {
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.tableViewController.view setAlpha:1];
        } completion:^(BOOL finished){
            
        }];
    }
}

-(void) reloadTableViewWithSectionsError: (NSMutableArray *) sections {
    if (self.editMode) {
        self.customTableViewEdit.section.sections = sections;
        [self.customTableViewEdit performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    } else {
        self.customTableView.section.sections = sections;
        [self.customTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
    
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

-(void) cancelThreadsAndRequests {
    [super cancelThreadsAndRequests];
    self.customTableView = nil;
    self.customTableViewEdit = nil;
    self.tableViewController = nil;
    self.sourceData = nil;
}


@end
