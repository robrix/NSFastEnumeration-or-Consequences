#import <Foundation/Foundation.h>

@interface Average : NSObject

-(double)example1ForInSumOfNumbersInEnumeration:(id<NSFastEnumeration>)enumeration;

-(double)example2ManualSynchronousSumOfNumbersInEnumeration:(id<NSFastEnumeration>)enumeration;

-(void)example3AsynchronousSumOfNumbersInEnumeration:(id<NSFastEnumeration>)enumeration completionHandler:(void(^)(double average))completionHandler;

@end
