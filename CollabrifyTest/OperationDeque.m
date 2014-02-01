#import "OperationDeque.h"

@implementation Deque{
    NSMutableArray *deque;
}

-(id)init{
    self = [super init];
    if(self!=nil){
        deque = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)push_back:(id)obj{
    [deque addObject:obj];
}

-(id)popbot{
    id lastObj = [deque lastObject];
    [deque removeLastObject];
    return lastObj;
}

-(id)poptop{
    id firstObj = [deque firstObject];
    [deque removeObjectAtIndex:0];
    return firstObj;
}

-(NSUInteger)size{
    return deque.count;
}

-(id)top{
    return [[deque firstObject] copy];
}

-(id)bottom{
    return [[deque lastObject] copy];
}

-(BOOL)isEmpty{
    return deque.count == 0;
}

-(NSString *)description{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@"["];
    for (id s in deque) {
        [result appendFormat:@"%@, ",[s description]];
    }
    if (deque.count>0) {
        result = [[result stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", "]] mutableCopy];
    }
    [result appendString:@"]"];
    return result;
}


@end