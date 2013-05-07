//
//  CustomTableViewViewController.m
//  Test GridView
//
//  Created by Lorenzo Villarroel on 17/09/12.
//  Copyright (c) 2012 Lorenzo Villarroel. All rights reserved.
//

#import "CustomTableViewController.h"
#import "TVFramework.h"

@interface CustomTableViewController ()

@end

@implementation CustomTableViewController

@synthesize section = _section;
@synthesize viewController = _viewController;
@synthesize lastCellPressed = _lastCellPressed;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style backgroundView: (UIView*) backgroundView backgroundColor: (UIColor*) backgroundColor sections:(NSArray*)sections viewController: (UIViewController*) viewController title: (NSString *) title{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundView = backgroundView;
        self.backgroundColor = backgroundColor;
        self.section = [[Section alloc] initWithSections:sections];
        self.section.title = title;
        self.viewController = viewController;
        self.dataSource = self;
        self.delegate = self;
        self.tableViewBeingPressed = NO;
        [self reloadData];
    }
    return self;
}

/*******************************************************************************
 TableView
 ******************************************************************************/

// Nº de Secciones de la tabla
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.section getNumberOfSections];
}

// Nº de Celdas por Seccion
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.section getNumberOfCells:section];
}

// Devolvemos las Celdas correspondientes
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.section getCellFromSection:indexPath.section Row:indexPath.row].cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.section getCellHeightFromSection: indexPath.section Row: indexPath.row];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat temp;
    if ((temp =  [self.section getSectionTitleSize:section]) > 0) {
        return temp;
    }
    return tableView.sectionHeaderHeight;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat temp;
    if ((temp = [self.section getSectionSubtitleSize:section]) > 0) {
        return temp;
    }
    return tableView.sectionFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.section getSectionTitleAspect:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.section getSectionFooterAspect:section];
}

-(void) deselectCell: (CustomCell *) cell {
    sleep(1);
    [cell customDeselect];
}

// Acción a realizar cuando pulsamos sobre una Celda concreta
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell * customCell = [self.section getCellFromSection:indexPath.section Row:indexPath.row];
    if (customCell.isSelectable) {
        [customCell customSelect];
        [customCell executeAction:self.viewController];
        self.lastCellPressed = customCell;
    }
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell * customCell = [self.section getCellFromSection:indexPath.section Row:indexPath.row];
    if (customCell.isSelectable) {
        [customCell customDeselect];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.tableViewBeingPressed = YES;
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewBeingScrolled" object:nil];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.tableViewBeingPressed = NO;
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewEndingScrolled" object:nil];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ////NSLog(@"hiding cell at indexPath: %d,%d",indexPath.row,indexPath.section);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    ////NSLog(@"hiding headerView");
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    ////NSLog(@"hiding footerView");
}

@end

/****
 Section
 ****/
@implementation Section

@synthesize numberOfSections = _numberOfSections;
@synthesize numberOfCells = _numberOfCells;
@synthesize title = __title;
@synthesize sections = _sections;


-(int) getNumberOfSections{
    return self.sections.count;
}

-(int) getNumberOfCells:(int) section {
    SectionElement * sectionElement;
    sectionElement = [self.sections objectAtIndex:section];//Nos metemos dentro de la seccion
    return [sectionElement.cells count];//Devolvemos el numero de celdas de esa seccion
}

- (NSString *) getTitle {
    return self.title;
}

-(CustomCell *) getCellFromSection: (int) section Row: (int) row {
    SectionElement * sectionElement;
    CustomCell * customCell;
    sectionElement = [self.sections objectAtIndex:section];//Buscamos la seccion que sea
    customCell = [sectionElement.cells objectAtIndex:row];//Dentro de la seccion, buscamos la celda correspondiente
    return customCell;
}

/*-(NSString *) getTituloSeccion: (NSInteger)section{
 ElementoSeccion * eSeccion;
 eSeccion = [self.sections objectAtIndex:section];//Nos metemos dentro de la seccion
 return eSeccion.tituloSeccion;//Devolvemos el titulo de la seccion
 }*/


-(NSString *) getSectionSubtitle: (NSInteger)section {
    SectionElement * sectionElement;
    sectionElement = [self.sections objectAtIndex:section];//Nos metemos dentro de la seccion
    return sectionElement.sectionSubtitle;//Devolvemos el subtitulo de la seccion
}


-(CGFloat) getSectionTitleSize: (NSInteger) section {
    SectionElement * sectionElement;
    sectionElement = [self.sections objectAtIndex:section];
    return sectionElement.heightHeader;
}


-(CGFloat) getSectionSubtitleSize: (NSInteger) section {
    SectionElement *sectionElement;
    sectionElement = [self.sections objectAtIndex:section];
    return sectionElement.heightFooter;
}


-(CGFloat) getCellHeightFromSection: (int) section Row: (int) row {
    CustomCell * customCell;
    SectionElement *sectionElement;
    sectionElement = [self.sections objectAtIndex:section];
    customCell = [sectionElement.cells objectAtIndex:row];
    return customCell.customCellAppearance.heightCell;
}


-(UIView *) getSectionTitleAspect: (NSInteger)section {
    SectionElement *sectionElement;
    sectionElement = [self.sections objectAtIndex:section];
    return [sectionElement getHeader];
}

-(UIView *) getSectionFooterAspect: (NSInteger)section {
    SectionElement *sectionElement;
    sectionElement = [self.sections objectAtIndex:section];
    return [sectionElement getFooter];
}


- (id)initWithSections: (NSArray *) sectionsElements {
    self = [super init];
    if (self) {
        self.sections = [[NSMutableArray alloc] init];
        for (SectionElement * sectionElement in sectionsElements) {
            [self.sections addObject:sectionElement];
        }
        self.numberOfSections = [self.sections count];
        self.title = @"Test";
    }
    return self;
}



@end
