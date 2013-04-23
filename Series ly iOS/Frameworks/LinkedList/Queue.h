//
//  Queue.h
//  PrototipoElMundo
//
//  Created by Lorenzo Villarroel on 25/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @Class Queue
 @Description cola que implementa su comportamiento con una linkedList por debajo
 @Property linkedList
 @Method dequeue
 @Method enqueueInformation
 @Method toString
 **/
@class LinkedList;
@interface Queue : NSObject

@property(strong,nonatomic) LinkedList * linkedList;

- (id) dequeue: (NSError **) error;
- (void) enqueueInformation: (id) information;
- (void) toString;

@end
