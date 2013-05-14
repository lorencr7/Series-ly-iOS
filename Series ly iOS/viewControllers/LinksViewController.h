//
//  LinksViewController.h
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 25/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "LoadableViewController.h"
@class MediaElementUserPending, CustomTableViewController, Links, FullInfo;
@interface LinksViewController : LoadableViewController

@property(strong,nonatomic) MediaElementUserPending * mediaElementUserPending;
@property(strong,nonatomic) FullInfo * fullInfo;

@property(strong,nonatomic) UISegmentedControl * segmentedControl;

//@property(strong,nonatomic) CustomTableViewController * tableViewLinks;
//@property(strong,nonatomic) UIView * viewTableViewLinks;

@property(strong,nonatomic) Links * links;

- (id)initWithMediaElementUserPending: (MediaElementUserPending *) mediaElementUserPending;

@end
