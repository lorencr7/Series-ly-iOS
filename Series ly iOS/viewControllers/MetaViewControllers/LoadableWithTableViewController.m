//
//  LoadableViewController.m
//  FI UPM
//
//  Created by Lorenzo Villarroel on 14/05/13.
//  Copyright (c) 2013 Laboratorio Ingeniería del Software. All rights reserved.
//

#import "LoadableWithTableViewController.h"
#import "TVFramework.h"

@interface LoadableWithTableViewController ()

@end

@implementation LoadableWithTableViewController

- (void)viewDidLoad {
    [self iniciarTableView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    
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

-(void) getData {
    [self getSections];
    [self.threads removeObject:[NSThread currentThread]];
}

-(void) getSections {
    self.sourceData = [self getSourceData];
    NSMutableArray * sections = [self getSectionsFromSourceData:self.sourceData];
    [self stopActivityIndicator];
    [self reloadTableViewWithSections:sections];
}

-(NSMutableArray *) getSourceData {
    return nil;
}

-(NSMutableArray *) getSectionsFromSourceData: (NSMutableArray *) sourceData {
    
    return nil;
}



@end
