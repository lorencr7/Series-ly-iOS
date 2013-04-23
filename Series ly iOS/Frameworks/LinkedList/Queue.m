//
//  Queue.m
//  PrototipoElMundo
//
//  Created by Lorenzo Villarroel on 25/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Queue.h"
#import "LinkedList.h"
#import "LinkedListNode.h"

/**
 @Class Queue
 @Description cola que implementa su comportamiento con una linkedList por debajo
 @Method init
 @Method dequeue
 @Method enqueueInformation
 @Method toString
 **/
@implementation Queue
@synthesize linkedList = _linkedList;

/**
 @Method init
 @Description metodo init de la cola
 @Return id
 **/
- (id)init
{
    self = [super init];
    if (self) {
        self.linkedList = [[LinkedList alloc] init];
    }
    return self;
}

/**
 @Method dequeue
 @Description metodo encargado de extraer un elemento en la cola
 @Param (NSError **) error
 @Return id
 **/
- (id) dequeue: (NSError **) error {
    [self.linkedList toTheStart];
    LinkedListNode * node = [self.linkedList current:error];
    [self.linkedList deleteCurrent:error];
    return node.element;
}

/**
 @Method enqueueInformation
 @Description metodo encargado de introducir un elemento en la cola
 @Param (id) information
 @Return void
 **/
- (void) enqueueInformation: (id) information {
    [self.linkedList toTheEnd];
    [self.linkedList insertNodeWithInformation:information insertBefore:NO];
}

/**
 @Method toString
 @Description metodo que nos permite imprimir el contenido de la cola
 @Return void
 **/
-(void) toString {
    /*Mensaje * mensaje;
    NSError * error;
    [self.linkedList toTheStart];
    printf("Cadena = (");
    while ([self.linkedList isThereNext]) {
        mensaje = self.linkedList.currentNode.element;
        printf("%s,",[mensaje.texto UTF8String]);
        [self.linkedList next:&error];
        if (error) {
            //NSLog(@"error:%@", error.localizedDescription);
            error = nil;
        }
    }
    mensaje = self.linkedList.currentNode.element;
    printf("%s)\n",[mensaje.texto UTF8String]);*/
}

@end
