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
@synthesize submissionID = _submissionID;
@synthesize originalString = _originalString;
@synthesize replacementString = _replacementString;
@synthesize range = _range;
@synthesize cursormove;

static int nextLocalID = 0;

- (Operation *) initLocal
{
    if(self = [super init])
    {
        // initialize localID unique for each local operation
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
