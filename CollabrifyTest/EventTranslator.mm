//
//  EventTranslator.m
//  WeWrite
//
//  Created by Tingyi on 1/28/14.
//  Copyright (c) 2014 Tingyi Wei. All rights reserved.
//

#import "EventTranslator.h"
#import "EventMessage.pb.h"

@implementation EventTranslator

+ (NSData *) operationToString: (Operation *) operation
{
    WeWrite::EventMessage message;
    
    message.set_participant_id([operation participantID]);
    message.set_local_id([operation localID]);
    message.set_global_id([operation globalID]);
    std::string c_str = [operation.originalString cStringUsingEncoding:[NSString defaultCStringEncoding]];
    message.set_originalstring(c_str);
    c_str = [operation.replacementString cStringUsingEncoding:[NSString defaultCStringEncoding]];
    message.set_replacementstring(c_str);
    WeWrite:: NSRange *range = new WeWrite::NSRange();
    range->set_length(operation.range.length);
    range->set_location(operation.range.location);
    message.set_allocated_range(range);
    
    // Serialize as NSData
    std::string serilized_str = message.SerializeAsString();
    if(!serilized_str.size())
    {
        NSLog(@"Failed to serilize operation.\n");
        return nil;
    }
    
    NSData *textData = [NSData dataWithBytes:serilized_str.c_str() length:serilized_str.size()];
    
    return textData;
}
/*
+ (Operation *) stringToOperation: (NSData *) textData
{
    Operation *operation = [[Operation alloc] initGlobal]
}*/
@end
