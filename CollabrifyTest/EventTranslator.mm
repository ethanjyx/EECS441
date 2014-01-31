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

- (int) sendOperation:(Operation *)operation
{
    WeWrite::EventMessage message;
    
    message.set_participant_id([operation participantID]);
    message.set_local_id([operation localID]);
    message.set_global_id([operation globalID]);
    std::string c_str = [operation.str cStringUsingEncoding:[NSString defaultCStringEncoding]];
    message.set_str(c_str);
    message.set_cursor_location([operation cursorLocation]);
    message.set_operation_type((::WeWrite:: EventMessage_OperationType)(operation.operationType));
    
    std::string serilized_str;
    if(!message.SerializeAsString(&serilized_str))
    {
        cerr << "Failed to serilize operation." << endl;
        return -1;
    }
    textData = [NSData dataWithBytes:serilized_str.c_str() length:serilized_str.size()];
    int submissionRegistrationID = [ broadcast:textData eventType:nil];
    if(submissionRegistrationID == -1)
    
    return 1;
}

@end
