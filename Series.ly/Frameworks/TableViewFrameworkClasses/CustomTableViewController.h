//
//  CustomTableViewViewController.h
//  Test GridView
//
//  Created by Lorenzo Villarroel on 17/09/12.
//  Copyright (c) 2012 Lorenzo Villarroel. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CustomCell,Section;
@interface CustomTableViewController : UITableView <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic,readwrite) Section * section;
@property (strong,nonatomic,readwrite) UIViewController * viewController;
@property (strong,nonatomic,readwrite) CustomCell * lastCellPressed;
@property (assign,nonatomic,readwrite) BOOL tableViewBeingPressed;
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style backgroundView: (UIView*) backgroundView backgroundColor: (UIColor*) backgroundColor sections:(NSArray*)sections viewController: (UIViewController*) viewController title: (NSString *) title;
@end





@interface Section: NSObject
@property (assign,nonatomic,readwrite) int numberOfSections;
@property (assign,nonatomic,readwrite) int numberOfCells;
@property (strong,nonatomic,readwrite) NSString *title;
@property (strong,nonatomic,readwrite) NSMutableArray * sections;
//Devuelve el numero de secciones del apartado
-(int) getNumberOfSections;
//Devuelve el numero de celdas por seccion
-(int) getNumberOfCells:(int) section;
//Devuelve el titulo del apartado
- (NSString *) getTitle;
//Nos devuelve el CeldaCap Correspondiente a una posicion concreta dentro del UITableView
-(CustomCell *) getCellFromSection: (int) section Row: (int) row;
//Nos devuelve el titulo de la seccion
//-(NSString *) getTituloSeccion: (NSInteger)section;
//Nos devuelve el subtitulo de la seccion
-(NSString *) getSectionSubtitle: (NSInteger)section;
//Nos devuelve el tamano del titulo seccion
-(CGFloat) getSectionTitleSize: (NSInteger) section;
//Nos devuelve el tamano del subtitulo seccion
-(CGFloat) getSectionSubtitleSize: (NSInteger) section;
//Nos devuelve el tamano de la celda
-(CGFloat) getCellHeightFromSection: (int) section Row: (int) row;
-(UIView *) getSectionTitleAspect: (NSInteger)section;
-(UIView *) getSectionFooterAspect: (NSInteger)section;
- (id)initWithSections: (NSArray *) sectionsElements;
@end


