#import <Foundation/Foundation.h>

@interface Deque : NSObject

-(void)push_back:(id)obj;
-(id)poptop;
-(NSUInteger)size;
-(id)top;
-(id)bottom;
-(id)popbot;
-(BOOL)isEmpty;
-(NSMutableArray*) getDequeObj;
-(void) clear;
-(id)getObjAtIndex:(int)index;
-(void)removeObjAtIndex:(int)index;

@end