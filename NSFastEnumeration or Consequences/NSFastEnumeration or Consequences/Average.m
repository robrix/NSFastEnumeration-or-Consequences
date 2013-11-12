#import "Average.h"

@implementation Average

// Example 1: for(in)

-(double)example1ForInSumOfNumbersInEnumeration:(id<NSFastEnumeration>)enumeration {
	
	double sum = 0;
	
	NSUInteger n = 0;
	
	for (NSNumber *number in enumeration) {
		
		sum += number.doubleValue;
		
		n++;
		
	}
	
	double average = sum / n;
	
	return average;
	
}

































// Example 2: for(in)-alike

-(double)example2ManualSynchronousSumOfNumbersInEnumeration:(id<NSFastEnumeration>)enumeration {
	
	NSFastEnumerationState state = {};
	id __unsafe_unretained objects[16] = {};
	
	NSUInteger countThisCall = 0;
	
	unsigned long mutations = 0;
	
	double sum = 0;
	
	NSUInteger n = 0;
	
	do {
		
		countThisCall = [enumeration countByEnumeratingWithState:&state objects:objects count:sizeof objects / sizeof *objects];
		
		if (mutations && *state.mutationsPtr != mutations) {
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Enumeration mutated while accessed!" userInfo:nil];
		}
		
		for ( NSUInteger i = 0 ; i < countThisCall ; i++ ) {
			
			NSNumber *number = state.itemsPtr[i];
			
			sum += number.doubleValue;
			
			n++;
			
		}
		
		mutations = *state.mutationsPtr;
		
	} while (countThisCall > 0);
	
	double average = sum / n;
	
	return average;
	
}






























// Example 3: for(in)-alike, now with 50% less synchrony!

-(void)example3AsynchronousSumOfNumbersInEnumeration:(id<NSFastEnumeration>)enumeration completionHandler:(void(^)(double average))completionHandler {
		
	NSFastEnumerationState *state = calloc(1, sizeof(NSFastEnumerationState));
	
	[self recursivelyAverageEnumeration:enumeration sum:0 n:0 mutations:0 state:state completionHandler:completionHandler];
	
}

-(void)recursivelyAverageEnumeration:(id<NSFastEnumeration>)enumeration sum:(double)sumPrevious n:(NSUInteger)nPrevious mutations:(unsigned long)mutations state:(NSFastEnumerationState *)state completionHandler:(void(^)(double average))completionHandler {
	
	__block double sum = sumPrevious;
	__block NSUInteger n = nPrevious;
	
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		
		id __unsafe_unretained objects[16] = {};
		
		NSUInteger count = [enumeration countByEnumeratingWithState:state objects:objects count:sizeof objects / sizeof *objects];
		
		if (mutations && *(state->mutationsPtr) != mutations) {
			
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Enumeration mutated while accessed!" userInfo:nil];
			
		}
		
		for ( NSUInteger i = 0 ; i < count ; i++ ) {
			
			NSNumber *number = state->itemsPtr[i];
			
			sum += number.doubleValue;
			
			n++;
			
		}
		
		if (count) {
			
			[self recursivelyAverageEnumeration:enumeration sum:sum n:n mutations:*state->mutationsPtr state:state completionHandler:completionHandler];
			
		} else {
			
			completionHandler(sum / n);
			
		}
		
	}];
	
}






















@end
