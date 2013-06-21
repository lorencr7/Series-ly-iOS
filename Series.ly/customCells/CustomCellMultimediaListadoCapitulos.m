//
//  CustomCellMultimediaListadoCapitulos.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 18/05/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "CustomCellMultimediaListadoCapitulos.h"
#import "VerLinksViewController.h"
#import "MediaElement.h"
#import "MediaElement.h"
#import "Pending.h"

@implementation CustomCellMultimediaListadoCapitulos



- (id)initWithMediaElement: (MediaElement *) mediaElementUser Pending: (Pending *) pending{
    self = [super init];
    if (self) {
        self.mediaElementUser = mediaElementUser;
        self.pending = pending;
    }
    return self;
}

-(void) executeAction: (UIViewController *) viewController {
    //MediaElement * mediaElementUserPending = [[MediaElement alloc] initWithIdm:self.mediaElementUser.idm IdMedia:self.mediaElementUser.idMedia MediaType:self.mediaElementUser.mediaType Name:self.mediaElementUser.name MainGenre:self.mediaElementUser.mainGenre Year:self.mediaElementUser.year Seasons:self.mediaElementUser.seasons Episodes:self.mediaElementUser.episodes Url:self.mediaElementUser.url Poster:self.mediaElementUser.poster Pending:self.pending];
    self.mediaElementUser.pending = self.pending;
    VerLinksViewController * linksViewController = [[VerLinksViewController alloc] initWithMediaElement:(MediaElement *)self.mediaElementUser];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [viewController.navigationController pushViewController:linksViewController animated:YES];
    } else {
        //ListadoLinksViewController * listadoLinksViewController = [[ListadoLinksViewController alloc] initWithFrame:linksViewController.view.frame MediaElement:self.mediaElementUserPending];
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:linksViewController];
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        navigationController.navigationBar.tintColor = [UIColor colorWithRed:(40.0/255.0) green:(101.0/255.0) blue:(144/255.0) alpha:1];
        [viewController presentViewController:navigationController animated:YES completion:nil];
    }
}

@end