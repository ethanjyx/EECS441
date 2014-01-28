//
//  Operation.m
//  CollabrifyTest
//
//  Created by Tingyi on 1/26/14.
//  Copyright (c) 2014 Tingyi Wei. All rights reserved.
//

#import "Operation.h"

@implementation Operation

@synthesize participantID = _participantID;
@synthesize localID = _localID;
@synthesize globalID = _globalID;
@synthesize str = _str;
@synthesize cursorLocation = _cursorLocation;
@synthesize operationType = _operationType;

static int nextLocalID = 0;

- (Operation *) initLocal
{
    if(self = [super init])
    {
        _localID = [self.class getNextLocalID];
    }
    return self;
}

- (Operation *) initGlobal
{
    self = [super init];
    return self;
}

+ (int) getNextLocalID
{
    return ++nextLocalID;
}

@end
