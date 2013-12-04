//
//  CustomTableViewEditController.m
//  hooola
//
//  Created by elabi3 on 10/09/13.
//  Copyright (c) 2013 jobssy. All rights reserved.
//

#import "CustomTableViewEditController.h"
#import "SectionElement.h"
#import "CustomCell.h"

@implementation CustomTableViewEditController

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style backgroundView: (UIView*) backgroundView backgroundColor: (UIColor*) backgroundColor sections:(NSArray*)sections viewController: (UIViewController*) viewController title: (NSString *) title
{
    self = [super initWithFrame:frame style:style backgroundView:backgroundView backgroundColor:backgroundColor sections:sections viewController:viewController title:title];
    if (self) {
        // Initialization code
        UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
        [self addGestureRecognizer:longPressRecognizer];
        
        self.editModeButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"TableViewEditButton", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEditing)];
    }
    return self;
}

// Long Press over cell
-(void)onLongPress:(UILongPressGestureRecognizer*)pGesture
{
    if (pGesture.state == UIGestureRecognizerStateBegan) {
        //Do something to tell the user!
        UITableView* tableView = (UITableView*)self;
        CGPoint touchPoint = [pGesture locationInView:self];
        NSIndexPath* rowIndexPath = [tableView indexPathForRowAtPoint:touchPoint];
        if (rowIndexPath != nil) {
            NSLog(@"%d", rowIndexPath.row);
            // Ponemos sacar opciones (un activity estaría bien)
        }
    }
    if (pGesture.state == UIGestureRecognizerStateEnded) {
        
    }
}

// Edit Cell with Swipe
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) { // Boton de eliminar pulsado
        int countSections = [self.section.sections count];
        if (countSections > 0 && indexPath.section >= 0 && indexPath.section < countSections) {
            SectionElement *sectionElement = [self.section.sections objectAtIndex:indexPath.section];
            int countElements = [sectionElement.cells count];
            if (countElements > 0 && indexPath.row >= 0 && indexPath.row < countElements) {
                CustomCell * customCell = [sectionElement.cells objectAtIndex:indexPath.row];
                [customCell deleteCell:self.viewController];
                [sectionElement.cells removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
}

// Edit mode
-(void)toggleEditing
{
    if (self.isEditing) {
        [self.editModeButton setTitle:NSLocalizedString(@"TableViewEditButton", nil)];
    } else {
        [self.editModeButton setTitle:NSLocalizedString(@"TableViewCancelButton", nil)];
    }
    [self setEditing:!self.isEditing animated:YES];
}

// The editButtonItem will invoke this method.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if (editing) {
        // Execute tasks for editing status
        
    } else {
        // Execute tasks for non-editing status.
    }
}


@end
