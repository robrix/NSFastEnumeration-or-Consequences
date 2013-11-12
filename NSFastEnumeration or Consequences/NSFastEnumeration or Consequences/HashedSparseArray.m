#import "HashedSparseArray.h"

@interface Pair : NSObject
@property id key;
@property id value;
@end

@interface HashedSparseArray ()
@property (nonatomic, readonly) NSMutableArray *buckets;
@property (nonatomic, readonly) NSUInteger bucketCount;
@property (nonatomic) NSUInteger count;
@end

@implementation HashedSparseArray

-(instancetype)init {
	if ((self = [super init])) {
		
		static const NSUInteger kBucketCount = 7;
		
		_buckets = [NSMutableArray new];
		
		for (NSUInteger i = 0 ; i < kBucketCount ; i++) {
			[_buckets addObject:[NSMutableArray new]];
		}
		
	}
	return self;
}


-(NSUInteger)hashForIndex:(NSUInteger)index {
	// rough attempt at FNV-1a hash
	
	static const NSUInteger kFNVPrime = 1099511628211lu;
	static const NSUInteger kOffsetBasis = 14695981039346656037lu;
	static const NSUInteger kOctetMask = 0xFFlu;
	
	NSUInteger hash = kOffsetBasis;
	
	for (NSUInteger i = 0; i < sizeof(sizeof(NSUInteger)); i++) {
		NSUInteger octet = index & (kOctetMask << (i * 8));
		hash = hash ^ octet;
		hash = hash * kFNVPrime;
	}
	
	return hash;
}


-(NSMutableArray *)bucketForIndex:(NSUInteger)index {
	return self.buckets[[self hashForIndex:index] % self.buckets.count];
}

-(id)objectAtIndexedSubscript:(NSUInteger)index {
	return [self pairForIndex:index inBucket:[self bucketForIndex:index]].value;
}


-(Pair *)pairForIndex:(NSUInteger)index inBucket:(NSMutableArray *)bucket {
	
	for (Pair *pair in bucket) {
		
		if ([pair.key isEqual:@(index)]) {
			return pair;
		}
		
	}
	return nil;
	
}

-(Pair *)makePairForIndex:(NSUInteger)index inBucket:(NSMutableArray *)bucket {
	
	Pair *pair = [Pair new];
	pair.key = @(index);
	
	[bucket addObject:pair];
	
	_count++;
	
	return pair;
	
}

-(void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
	
	NSMutableArray *bucket = [self bucketForIndex:index];
	
	Pair *pair = [self pairForIndex:index inBucket:bucket] ?: [self makePairForIndex:index inBucket:bucket];
	pair.value = object;
	
}



#pragma mark NSFastEnumeration

typedef struct {
	unsigned long state;
    id __unsafe_unretained *itemsPtr;
    unsigned long *mutationsPtr;
	
	unsigned long currentBucket;
	unsigned long indexInCurrentBucket;
	unsigned long producedCount;
    unsigned long extra[2];
} HashedSparseArrayEnumerationState;

-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)stateToCast objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
	
	HashedSparseArrayEnumerationState *state = (HashedSparseArrayEnumerationState *)stateToCast;
	
	NSUInteger produced = MIN(len, self.count - state->producedCount);
	
	state->mutationsPtr = &_count;
	state->itemsPtr = buffer;
	
	NSUInteger currentProduced = 0;
	
	for (; state->currentBucket < self.buckets.count ; state->currentBucket++) {
		
		NSMutableArray *bucket = self.buckets[state->currentBucket];
		
		for (Pair *pair in bucket) {
			buffer[currentProduced++] = pair.key;
			
			if (currentProduced >= produced)
				break;
			
			state->indexInCurrentBucket++;
		}
		
		state->indexInCurrentBucket = 0;
	}
	
	state->producedCount = produced;
	
	return produced;
}

@end


@implementation Pair
@end
