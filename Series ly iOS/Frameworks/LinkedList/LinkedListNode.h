//
//  LinkedListNode.h
//  linkedlist
//
//  Created by Lorenzo Villarroel on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @Class LinkedListNode
 @Description nodo de la linkedList
 @Property element
 @Property previousNode
 @Property nextNode
 @Method initWithInformation
 **/
@interface LinkedListNode : NSObject

@property (strong,nonatomic) id element;
@property (strong,nonatomic) LinkedListNode * previousNode;
@property (strong,nonatomic) LinkedListNode * nextNode;

- (id)initWithInformation:(id) information  previousNode:(LinkedListNode*) previousNode  nextNode:(LinkedListNode*) nextNode;

@end
