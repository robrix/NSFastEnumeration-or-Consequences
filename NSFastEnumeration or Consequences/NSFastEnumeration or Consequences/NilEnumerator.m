#import "NilEnumerator.h"

@interface NilEnumerator ()
@property (nonatomic) NSUInteger n;
@end

@implementation NilEnumerator

-(instancetype)initWithN:(NSUInteger)n {
	if ((self = [super init])) {
		_n = n;
	}
	return self;
}


-(id)nextObject {
	return nil;
}


-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
	NSUInteger produced = MIN(len, _n);
	
	state->itemsPtr = buffer;
	state->mutationsPtr = state->extra;
	
	self.n -= produced;
	
	return produced;
}

@end
