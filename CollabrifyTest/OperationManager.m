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
@synthesize map = _map;

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
/*
- (Deque*) undoStack;
{
    if (_undoStack == nil) {
        _undoStack = [[Deque alloc] init];
    }
    return _undoStack;
}
*/
- (Deque*) redoStack;
{
    if (_redoStack == nil) {
        _redoStack = [[Deque alloc] init];
    }
    return _redoStack;
}

- (NSMutableDictionary*) map;
{
    if (_map == nil) {
        _map = [NSMutableDictionary dictionary];
    }
    return _map;
}

- (NSString*) confirmedText;{
    if (_confirmedText == nil) {
        _confirmedText = [[NSString alloc] init];
        _confirmedText = @"";
    }
    return _confirmedText;
}

- (void)setConfirmedText:(NSString *)Text
{
    if (_confirmedText == nil) {
        _confirmedText = [[NSString alloc] init];
        _confirmedText = @"";
    }
    _confirmedText = Text;
}
@end
