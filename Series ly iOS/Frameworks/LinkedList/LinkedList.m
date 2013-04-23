//
//  LinkedList.m
//  linkedlist
//
//  Created by Lorenzo Villarroel on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LinkedList.h"
#import "LinkedListNode.h"

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
 @Method isEqual
 @Method createError
 @Method init
 **/
@implementation LinkedList

@synthesize currentNode;
@synthesize tailNode;
@synthesize headNode;
@synthesize length = _length;

/**
 @Method init
 @Description metodo init de la LinkedList
 @Return id
 **/
- (id)init
{
    self = [super init];
    if (self) {
        self.length = 0;
    }
    return self;
}

/**
 @Method methodName
 @Description creamos un error 
 @Param (NSError **) error 
 @Param (int) code
 @Return void
 **/
-(void) createError: (NSError **) error Message:(NSString *) message Code: (int) code {
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:message
                                                          forKey:NSLocalizedDescriptionKey];
    
    // recordad que se trata de una doble indirección, así que hay que usar *err
    *error = [NSError errorWithDomain:@"Domain"
                                 code:code
                             userInfo:errorInfo];
}

/**
 @Method current
 @Description devolvemos el id actual en caso de que la linkedList no este vacia
 @Param (NSError **) error 
 @Return id
 **/
-(id) current : (NSError **) error {
    if ([self isEmpty]) {
        [self createError:error Message:@"Empty List" Code:1];
        return nil;
    }
    return currentNode.element;
}

/**
 @Method toTheEnd
 @Description vamos al final de la LinkedList
 @Return void
 **/
-(void) toTheEnd {
    currentNode = tailNode;
}

/**
 @Method toTheStart
 @Description vamos al principio de la LinkedList
 @Return void
 **/
-(void) toTheStart {
    currentNode = headNode;
}

/**
 @Method previous
 @Description cambiamos el nodo actual a su anterior
 @Param (NSError **) error
 @Return void
 **/
-(void) previous: (NSError **) error {
    if (![self isTherePrevious]) {
        [self createError:error Message:@"There is not previous element" Code:2];
    } else {
        currentNode = currentNode.previousNode;
    }
}

/**
 @Method next
 @Description cambiamos el nodo actual a su posterior 
 @Param (NSError **) error
 @Return void
 **/
-(void) next: (NSError **) error {
    if (![self isThereNext]) {
        [self createError:error Message:@"There is not next element" Code:3];
    } else {
        currentNode = currentNode.nextNode;
    }
}

/**
 @Method deleteCurrent
 @Description eliminamos el nodo actual 
 @Param (NSError **) error
 @Return void
 **/
-(void) deleteCurrent : (NSError **) error {
    if ([self isEmpty]) {
        [self createError:error Message:@"Empty List" Code:1];
    } else {
        if (![self isTherePrevious]) {//first node
            headNode = currentNode.nextNode;
            [self next:nil];
            currentNode.previousNode = nil;
        } else {
            if (![self isThereNext]) {//last node
                tailNode = currentNode.previousNode;
                [self previous:nil];
                currentNode.nextNode = nil;
            } else {//node surrounded
                currentNode.nextNode.previousNode = currentNode.previousNode;
                currentNode = currentNode.nextNode;
                currentNode.previousNode.nextNode = currentNode;
            }
        }
    }
    self.length -=1;
}

/**
 @Method isEmpty
 @Description comprobamos si la linkedListe esta vacia
 @Return (BOOL)
 **/
-(BOOL) isEmpty {
    return self.length == 0;
}

/**
 @Method isThereNext
 @Description comprobamos si existe un nodo siguiente al actual
 @Return (BOOL)
 **/
-(BOOL) isTherePrevious {
    return currentNode != headNode;
}

/**
 @Method isThereNext
 @Description comprobamos si existe un nodo anterior al actual
 @Return (BOOL)
 **/
-(BOOL) isThereNext {
    return currentNode != tailNode;
}

/**
 @Method insertNodeWithInformation
 @Description insertamos un nuevo nodo en la linkedList
 @Param (id) information
 @Param (BOOL) insertBefore
 @Return void
 **/
-(void) insertNodeWithInformation: (id) information  insertBefore: (BOOL) insertBefore {
    LinkedListNode * linkedListNode;
    if ([self isEmpty]) {
        ////NSLog(@"insert1");
        linkedListNode = [[LinkedListNode alloc] initWithInformation:information previousNode:nil nextNode:nil];
        currentNode = linkedListNode;
        headNode = linkedListNode;
        tailNode = linkedListNode;
    } else {
        if (insertBefore) {
            if (![self isTherePrevious]) {//actual == first
                ////NSLog(@"insert2");
                linkedListNode = [[LinkedListNode alloc] initWithInformation:information previousNode:nil nextNode:currentNode];
                currentNode.previousNode = linkedListNode;
                headNode = linkedListNode;
            } else {
                ////NSLog(@"insert3");
                linkedListNode = [[LinkedListNode alloc] initWithInformation:information previousNode:currentNode.previousNode nextNode:currentNode];
                currentNode.previousNode.nextNode = linkedListNode;
                currentNode.previousNode = linkedListNode;
            }
        } else {//actual == last
            if (![self isThereNext]) {
                ////NSLog(@"insert4");
                linkedListNode = [[LinkedListNode alloc] initWithInformation:information previousNode:currentNode nextNode:nil];
                currentNode.nextNode = linkedListNode;
                tailNode = linkedListNode;
            } else {
                ////NSLog(@"insert5");
                linkedListNode = [[LinkedListNode alloc] initWithInformation:information previousNode:currentNode nextNode:currentNode.nextNode];
                currentNode.nextNode.previousNode = linkedListNode;
                currentNode.nextNode = linkedListNode;
            }
        }
        currentNode = linkedListNode;
    }
    self.length +=1;
}

/**
 @Method insertNodesWithArray
 @Description insertamos n nodos a partir de un array a la linkedList
 @Param (NSArray*) nodes
 @Param (BOOL) insertBefore
 @Return void
 **/
-(void) insertNodesWithArray: (NSArray*) nodes  insertBefore: (BOOL) insertBefore {
    int i = 0;
    if (insertBefore) {
        for (LinkedListNode * node in nodes) {
            if (i == 0) {
                [self insertNodeWithInformation:node insertBefore:insertBefore];
                i++;
            } else {
                [self insertNodeWithInformation:node insertBefore:!insertBefore];
            }   
        }
    } else {
        for (LinkedListNode * node in nodes) {
            [self insertNodeWithInformation:node insertBefore:insertBefore];
        } 
    }
}

/**
 @Method isEqual
 @Description comprobamos si dos linkedList son iguales
 @Param (id)object
 @Return (BOOL)
 **/
-(BOOL) isEqual:(id)object {
    if ([object class] != [LinkedList class]) {
        return NO;
    }
    LinkedList * linkedList = (LinkedList *) object;
    if (linkedList.length != self.length) {
        return NO;
    }

    id element1,element2;
    NSError * error1;
    NSError * error2;
    [linkedList toTheStart];
    [self toTheStart];
    while ([linkedList isThereNext]) {
        element1 = self.currentNode.element;
        element2 = linkedList.currentNode.element;
        
        if (![element1 isEqual:element2]) {
            return NO;
        }
        
        [self next:&error1];
        [linkedList next:&error2];
        if (error1 || error2) {
            ////NSLog(@"error:%@", error.localizedDescription);
            error1 = nil;
            error2 = nil;
        }
    }
    element1 = self.currentNode.element;
    element2 = linkedList.currentNode.element;

    if (![element1 isEqual:element2]) {
        return NO;
    }
    return YES;
    
    
}


@end
