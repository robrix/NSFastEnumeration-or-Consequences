#import <Foundation/Foundation.h>

@interface DoubleArray : NSObject <NSFastEnumeration>

@property (nonatomic, readonly) NSUInteger count;

-(void)addDouble:(double)number;

@end
