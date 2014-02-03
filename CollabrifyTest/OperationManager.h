//
//  OperationManager.h
//  CollabrifyTest
//
//  Created by Shuo Yang on 2/1/14.
//  Copyright (c) 2014 Collabrify.it. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationDeque.h"

@interface OperationManager : NSObject

// Singleton class, since we need to operate the same stacks from different view controller and class.
+ (OperationManager *) getOperationManager;

// Use for tracking all confirmed operations.
@property (strong, nonatomic) Deque *confirmedOp;

// Use for local unconfirmed operations.
@property (strong, nonatomic) Deque *unconfirmedOp;

// The stack that can redo.
@property (strong, nonatomic) Deque *redoStack;

// Text after confirmed operations.
@property (strong, nonatomic) NSString *confirmedText;

@property (strong, nonatomic) NSMutableDictionary *map;

@end
