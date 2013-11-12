#import <XCTest/XCTest.h>
#import <NSFastEnumeration or Consequences/FibonacciStringEnumerator.h>
#import <NSFastEnumeration or Consequences/MapEnumerator.h>
#import <NSFastEnumeration or Consequences/NilEnumerator.h>

@interface LazyEvaluationWithNSEnumeratorTests : XCTestCase
@end

@implementation LazyEvaluationWithNSEnumeratorTests

-(NSArray *)firstN:(NSUInteger)n inEnumeration:(id<NSFastEnumeration>)enumeration {
	NSMutableArray *objects = [NSMutableArray new];
	
	for (id each in enumeration) {
		if (objects.count >= n) break;
		
		[objects addObject:each];
	}
	
	return objects;
}


// Example 7: generating temporaries

-(void)testExample7GeneratingTemporariesWithAnEnumerator {
	
	NSArray *strings = [self firstN:8 inEnumeration:[FibonacciStringEnumerator new]];
	
	XCTAssertEqualObjects(strings, (@[@"1", @"11", @"112", @"1123", @"11235", @"112358", @"11235813", @"1123581321"]), @"");
	
}















// Example 8: lazy map over another enumerator

-(void)testExample8LazilyMappingWithComposedEnumerators {
	
	MapEnumerator *stringLengths = [[MapEnumerator alloc] initWithEnumerator:[FibonacciStringEnumerator new] block:^id(NSString *each) {
		return @(each.length);
	}];
	
	NSArray *lengths = [self firstN:8 inEnumeration:stringLengths];
	
	XCTAssertEqualObjects(lengths, (@[@1, @2, @3, @4, @5, @6, @8, @10]), @"");
	
}
















// Example 9: producing nil

-(void)testExample9ProducingNil {
	
	NSUInteger n = 0;
	
	for (id each in [[NilEnumerator alloc] initWithN:512]) {
		n++;
	}
	
	XCTAssertEqual(n, 512lu, @"");
	
}




















// Example 10: push-me-pull-you



@end
