#import <Foundation/Foundation.h>

@interface PushEnumerator : NSEnumerator

@property (nonatomic, readonly) id currentObject;

-(void)pushObject:(id)object;
-(void)pushObjectsInArray:(NSArray *)objects;

@end
