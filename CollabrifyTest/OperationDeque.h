#import <Foundation/Foundation.h>

@interface Deque : NSObject

-(void)push_back:(id)obj;
-(id)poptop;
-(NSUInteger)size;
-(id)top;
-(id)bottom;
-(id)popbot;
-(BOOL)isEmpty;

@end