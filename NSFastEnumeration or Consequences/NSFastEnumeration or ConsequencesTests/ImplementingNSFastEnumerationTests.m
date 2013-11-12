#import <XCTest/XCTest.h>

#import <NSFastEnumeration or Consequences/DoubleArray.h>

@interface ImplementingNSFastEnumerationTests : XCTestCase
@end

@implementation ImplementingNSFastEnumerationTests

-(double)average:(id<NSFastEnumeration>)enumeration {
	double sum = 0;
	NSUInteger n = 0;
	
	for (NSNumber *number in enumeration) {
		sum += number.doubleValue;
		n++;
	}
	
	return sum / n;
}


// Example 4: delegating to another collection

-(void)testExample4DelegatingNSFastEnumeration {
	
	DoubleArray *array = [DoubleArray new];
	[array addDouble:0];
	[array addDouble:1];
	[array addDouble:2];
	[array addDouble:3];
	
	XCTAssertEqual([self average:array], 1.5, @"");
	
}








// Example 5: contiguous internal buffer
// Example 6: copying batches into buffer
// Example 7: generating temporaries*

@end
