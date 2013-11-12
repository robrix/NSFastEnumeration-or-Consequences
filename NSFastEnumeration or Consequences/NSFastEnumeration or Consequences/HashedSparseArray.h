#import <Foundation/Foundation.h>

@interface HashedSparseArray : NSObject <NSFastEnumeration>

-(id)objectAtIndexedSubscript:(NSUInteger)index;
-(void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end
