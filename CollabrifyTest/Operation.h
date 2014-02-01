//
//  Operation.h
//  CollabrifyTest
//
//  Created by Tingyi on 1/26/14.
//  Copyright (c) 2014 Collabrify.it. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operation : NSObject

@property int participantID;
@property int localID;
@property int globalID;
@property int submissionID;
@property NSString *originalString;
@property NSString *replacementString;
@property NSRange range;

// Initializer for local operations, which will assign localID to the operation
- (Operation *) initLocal;

// Initializer for global operations
- (Operation *) initGlobal;

// Class variable to record next localID to assign
+ (int) getNextLocalID;

@end
