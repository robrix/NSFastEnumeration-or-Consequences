#import <XCTest/XCTest.h>

#import <NSFastEnumeration or Consequences/DoubleArray.h>
#import <NSFastEnumeration or Consequences/Point3D.h>

@interface ImplementingNSFastEnumerationTests : XCTestCase
@end

@implementation ImplementingNSFastEnumerationTests










// Example 4: delegating to another collection

-(void)testExample4DelegatingNSFastEnumeration {
	
	DoubleArray *array = [DoubleArray new];
	[array addDouble:0];
	[array addDouble:1];
	[array addDouble:2];
	[array addDouble:3];
	
	double sum = 0;
	NSUInteger n = 0;
	
	for (NSNumber *number in array) {
		sum += number.doubleValue;
		n++;
	}
	
	double average = sum / n;
	
	XCTAssertEqual(average, 1.5, @"");
	
}








// Example 5: contiguous internal buffer

-(void)testExample5NSFastEnumerationImplementedOverAContiguousInternalBuffer {
	
	Point3D *point = [[Point3D alloc] initWithX:2 Y:3 Z:6];
	
	XCTAssertEqual(point.magnitude, 7.0, @"");
	
}














// Example 6: copying batches into buffer
























// Example 7: generating temporaries*


















@end
