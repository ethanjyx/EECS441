//
//  EventTranslator.h
//  WeWrite
//
//  Created by Tingyi on 1/28/14.
//  Copyright (c) 2014 Tingyi Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Operation.h"

@interface EventTranslator : NSObject

- (void) sendOperation: (Operation *) operation;

@end
