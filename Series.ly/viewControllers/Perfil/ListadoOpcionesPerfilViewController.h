//
//  ListadoOpcionesPerfilViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 28/04/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableWithTableViewController.h"

@class CustomTableViewController,ListadoCapitulosPendientesViewController;
@interface ListadoOpcionesPerfilViewController : LoadableWithTableViewController

@property (assign, nonatomic) CGRect frame;
//@property (strong, nonatomic) CustomTableViewController *tableViewSeleccion;
@property (strong, nonatomic) ListadoCapitulosPendientesViewController *listadoCapitulosPendientes;

- (id)initWithFrame: (CGRect) frame ListadoCapitulosPendientes: (ListadoCapitulosPendientesViewController *) listadoCapitulosPendientes;

@end

#define UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor whiteColor]
#define SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor blackColor]
#define TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE [UIColor blackColor]
#define UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE [UIFont systemFontOfSize:18.0]
#define SELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE [UIFont systemFontOfSize:18.0]
#define BORDERCOLORPERFILSELECCIONIPHONE [UIColor whiteColor]
#define BORDERWIDTHPERFILSELECCIONIPHONE 0.8
#define CORNERRADIUSPERFILSELECCIONIPHONE 0
#define TEXTALIGNMENTPERFILSELECCIONIPHONE NSTextAlignmentLeft
#define ACCESORYTYPEPERFILSELECCIONIPHONE UITableViewCellAccessoryDisclosureIndicator
#define LINEBREAKMODEPERFILSELECCIONIPHONE NSLineBreakByWordWrapping
#define NUMBEROFLINESPERFILSELECCIONIPHONE 0
#define ACCESORYVIEWPERFILSELECCIONIPHONE nil
#define HEIGHTCELLPERFILSELECCIONIPHONE 68

#define APARIENCIAPERFILSELECCIONIPHONE [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE selectedColor:SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPHONE unselectedTextFont:UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE selectedTextFont:SELECTEDFONTAPARIENCIAPERFILSELECCIONIPHONE borderColor:BORDERCOLORPERFILSELECCIONIPHONE borderWidth:BORDERWIDTHPERFILSELECCIONIPHONE cornerRadius:CORNERRADIUSPERFILSELECCIONIPHONE textAlignment:TEXTALIGNMENTPERFILSELECCIONIPHONE accesoryType:ACCESORYTYPEPERFILSELECCIONIPHONE lineBreakMode:LINEBREAKMODEPERFILSELECCIONIPHONE numberOfLines:NUMBEROFLINESPERFILSELECCIONIPHONE accesoryView:ACCESORYVIEWPERFILSELECCIONIPHONE heightCell:HEIGHTCELLPERFILSELECCIONIPHONE]

#define UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor whiteColor]
#define SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor colorWithRed:(133/255.0) green:(163/255.0) blue:(206/255.0) alpha:1]
#define TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor blackColor]
#define TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD [UIColor blackColor]
#define UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD [UIFont systemFontOfSize:20.0]
#define SELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD [UIFont systemFontOfSize:20.0]
#define BORDERCOLORPERFILSELECCIONIPAD [UIColor whiteColor]
#define BORDERWIDTHPERFILSELECCIONIPAD 0.8
#define CORNERRADIUSPERFILSELECCIONIPAD 0
#define TEXTALIGNMENTPERFILSELECCIONIPAD NSTextAlignmentLeft
#define ACCESORYTYPEPERFILSELECCIONIPAD UITableViewCellAccessoryDisclosureIndicator
#define LINEBREAKMODEPERFILSELECCIONIPAD NSLineBreakByWordWrapping
#define NUMBEROFLINESPERFILSELECCIONIPAD 0
#define ACCESORYVIEWPERFILSELECCIONIPAD nil
#define HEIGHTCELLPERFILSELECCIONIPAD 90

#define APARIENCIAPERFILSELECCIONIPAD [[CustomCellAppearance alloc] initWithAppearanceWithUnselectedColor:UNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD selectedColor:SELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD unselectedTextColor:TEXTUNSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD selectedTextColor:TEXTSELECTEDCOLORAPARIENCIAPERFILSELECCIONIPAD unselectedTextFont:UNSELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD selectedTextFont:SELECTEDFONTAPARIENCIAPERFILSELECCIONIPAD borderColor:BORDERCOLORPERFILSELECCIONIPAD borderWidth:BORDERWIDTHPERFILSELECCIONIPAD cornerRadius:CORNERRADIUSPERFILSELECCIONIPAD textAlignment:TEXTALIGNMENTPERFILSELECCIONIPAD accesoryType:ACCESORYTYPEPERFILSELECCIONIPAD lineBreakMode:LINEBREAKMODEPERFILSELECCIONIPAD numberOfLines:NUMBEROFLINESPERFILSELECCIONIPAD accesoryView:ACCESORYVIEWPERFILSELECCIONIPAD heightCell:HEIGHTCELLPERFILSELECCIONIPAD]