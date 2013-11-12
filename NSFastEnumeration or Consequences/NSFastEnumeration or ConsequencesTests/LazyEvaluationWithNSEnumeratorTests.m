#import <XCTest/XCTest.h>
#import <NSFastEnumeration or Consequences/FibonacciStringEnumerator.h>

@interface LazyEvaluationWithNSEnumeratorTests : XCTestCase
@end

@implementation LazyEvaluationWithNSEnumeratorTests

// Example 7: generating temporaries

-(void)testGeneratingTemporariesWithAnEnumerator {
	
	NSMutableArray *strings = [NSMutableArray new];
	
	for (NSString *string in [FibonacciStringEnumerator new]) {
		if (strings.count >= 8) break;
		
		[strings addObject:string];
	}
	
	XCTAssertEqualObjects(strings, (@[@"1", @"11", @"112", @"1123", @"11235", @"112358", @"11235813", @"1123581321"]), @"");
	
}








// Example 8: lazy map over another enumerator







// Example 9: producing nil




// Example 10: push-me-pull-you

@end
