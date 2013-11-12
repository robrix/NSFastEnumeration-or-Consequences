#import <XCTest/XCTest.h>

#import <NSFastEnumeration or Consequences/DoubleArray.h>
#import <NSFastEnumeration or Consequences/Point3D.h>
#import <NSFastEnumeration or Consequences/HashedSparseArray.h>

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

-(void)testExample6NSFastEnumerationImplementedByReturningOwnedObjectsInBatches {
	
	HashedSparseArray *array = [HashedSparseArray new];
	array[4] = @"Four";
	array[10] = @"Ten";
	array[55] = @"Fifty-five";
	array[30] = @"Thirty";
	array[1] = @"One";
	
	NSMutableSet *indices = [NSMutableSet new];
	for (NSNumber *index in array) {
		[indices addObject:index];
	}
	
	XCTAssertEqualObjects(indices, ([NSSet setWithArray:@[@1, @4, @10, @30, @55]]), @"");
	
}






















// Example 7: generating temporaries*


















@end
