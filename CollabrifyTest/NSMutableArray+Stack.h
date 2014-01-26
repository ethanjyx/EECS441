#import <Foundation/Foundation.h>

@interface Stack : NSObject

-(void)push:(id)obj;
-(id)pop;
-(NSUInteger)size;
-(id)peek;
-(BOOL)isEmpty;

@end