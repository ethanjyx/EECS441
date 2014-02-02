//
//  OperationManager.m
//  CollabrifyTest
//
//  Created by Shuo Yang on 2/1/14.
//  Copyright (c) 2014 Collabrify.it. All rights reserved.
//

#import "OperationManager.h"

@implementation OperationManager

static OperationManager* manager;

@synthesize confirmedOp = _confirmedOp;
@synthesize unconfirmedOp = _unconfirmedOp;
@synthesize redoStack = _redoStack;
@synthesize confirmedText = _confirmedText;

+ (OperationManager*) getOperationManager
{
    if (manager == nil){
        manager = [[OperationManager alloc] init];
    }
    return manager;
}

- (Deque*) confirmedOp;
{
    if (_confirmedOp == nil) {
        _confirmedOp = [[Deque alloc] init];
    }
    return _confirmedOp;
}

- (Deque*) unconfirmedOp;
{
    if (_unconfirmedOp == nil) {
        _unconfirmedOp = [[Deque alloc] init];
    }
    return _unconfirmedOp;
}

- (Deque*) redoStack;
{
    if (_redoStack == nil) {
        _redoStack = [[Deque alloc] init];
    }
    return _redoStack;
}

- (void)setConfirmedText:(NSString *)Text
{
    if (_confirmedText == nil) {
        _confirmedText = [[NSString alloc] init];
        _confirmedText = @"";
    }
    self.confirmedText = Text;
}
@end
