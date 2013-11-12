#import "FibonacciStringEnumerator.h"

@interface FibonacciStringEnumerator ()
@property NSString *currentString;
@property NSUInteger previousNumber;
@property NSUInteger currentNumber;
@end

@implementation FibonacciStringEnumerator

-(instancetype)init {
	if ((self = [super init])) {
		_currentString = @"";
	}
	return self;
}

-(NSUInteger)nextNumber {
	NSUInteger nextNumber = self.previousNumber + self.currentNumber ?: 1;
	self.previousNumber = self.currentNumber;
	self.currentNumber = nextNumber;
	return nextNumber;
}

-(id)nextObject {
	return self.currentString = [self.currentString stringByAppendingFormat:@"%lu", (unsigned long)self.nextNumber];
}

@end
