#import <XCTest/XCTest.h>
#import <NSFastEnumeration or Consequences/Average.h>

@interface CallingNSFastEnumerationManuallyTests : XCTestCase
@property id<NSFastEnumeration> enumeration;
@property Average *average;
@end

@implementation CallingNSFastEnumerationManuallyTests

-(void)setUp {
	
	self.average = [Average new];
	
	self.enumeration = @[@1, @2, @3, @4];
	
}


















// Example 1: for(in)

-(void)testExample1ForInSyntaxForCallingNSFastEnumeration {
	
	XCTAssertEqual([self.average example1ForInSumOfNumbersInEnumeration:self.enumeration], 2.5, @"");
	
}





















// Example 2: for(in)-alike

-(void)testExample2CallingNSFastEnumerationManuallyInTheSameStyleAsForIn {
	
	XCTAssertEqual([self.average example2ManualSynchronousSumOfNumbersInEnumeration:self.enumeration], 2.5, @"");
	
}



















// Example 3: for(in)-alike, now with 50% less synchrony!

-(void)testExample3CallingNSFastEnumerationAsynchronously {
	
	__block double average = 0;
	__block bool didFinish = NO;
	
	[self.average example3AsynchronousSumOfNumbersInEnumeration:self.enumeration completionHandler:^(double result) {
		
		average = result;
		
		didFinish = YES;
		
	}];
	
	while (!didFinish) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
	}
	
	XCTAssertEqual(average, 2.5, @"");
	
}


@end
