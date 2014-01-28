#import "OperationStack.h"

@implementation Stack{
    NSMutableArray *stack;
}

-(id)init{
    self = [super init];
    if(self!=nil){
        stack = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)push:(id)obj{
    [stack addObject:obj];
}

-(id)pop{
    id lastObj = [stack lastObject];
    [stack removeLastObject];
    return lastObj;
}

-(NSUInteger)size{
    return stack.count;
}

-(id)peek{
    return [[stack lastObject] copy];
}

-(BOOL)isEmpty{
    return stack.count == 0;
}

-(NSString *)description{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@"["];
    for (id s in stack) {
        [result appendFormat:@"%@, ",[s description]];
    }
    if (stack.count>0) {
        result = [[result stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", "]] mutableCopy];
    }
    [result appendString:@"]"];
    return result;
}


@end