//
//  LinkedListNode.m
//  linkedlist
//
//  Created by Lorenzo Villarroel on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LinkedListNode.h"

/**
 @Class LinkedListNode
 @Description nodo de la linkedList
 @Method initWithInformation
 **/
@implementation LinkedListNode

@synthesize element = element;
@synthesize previousNode = _previousNode;
@synthesize nextNode = _nextNode;

/**
 @Method initWithInformation
 @Description metodo init personalizado para que le pasemos los parametros informacion, previousNode y nextNode
 @Param (id) information
 @Param (LinkedListNode*) previousNode
 @Param (LinkedListNode*) nextNode 
 @Return id
 **/
- (id)initWithInformation:(id) information  previousNode:(LinkedListNode*) previousNode  nextNode:(LinkedListNode*) nextNode 
{
    self = [super init];
    if (self) {
        self.element = information;
        self.previousNode = previousNode;
        self.nextNode = nextNode;
    }
    return self;
}

@end
