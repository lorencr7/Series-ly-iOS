//
//  LinkedList.h
//  linkedlist
//
//  Created by Lorenzo Villarroel on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
/*
 
 */
//

#import <Foundation/Foundation.h>

/**
 @Class LinkedList
 @Description clase encargada de gestionar una linkedList
 @Property headNode
 @Property tailNode
 @Property currentNode
 @Property length
 @Method current
 @Method toTheEnd
 @Method toTheStart
 @Method previous
 @Method next
 @Method deleteCurrent
 @Method isEmpty
 @Method isTherePrevious
 @Method isThereNext
 @Method insertNodeWithInformation
 @Method insertNodesWithArray
 **/
@class LinkedListNode;
@interface LinkedList : NSObject 

@property (strong,nonatomic) LinkedListNode * headNode;
@property (strong,nonatomic) LinkedListNode * tailNode;
@property (strong,nonatomic) LinkedListNode * currentNode;
@property (assign,nonatomic) int length;

-(id) current: (NSError **) error;
-(void) toTheEnd;
-(void) toTheStart;
-(void) previous: (NSError **) error;
-(void) next: (NSError **) error;
-(void) deleteCurrent: (NSError **) error;
-(BOOL) isEmpty;
-(BOOL) isTherePrevious;
-(BOOL) isThereNext;
-(void) insertNodeWithInformation: (id) information  insertBefore: (BOOL) insertBefore;
-(void) insertNodesWithArray: (NSArray*) nodes  insertBefore: (BOOL) insertBefore;


@end
