#import "MapEnumerator.h"

@interface MapEnumerator ()

@property NSEnumerator *enumerator;
@property (copy) id(^block)(id each);

@end

@implementation MapEnumerator

-(instancetype)initWithEnumerator:(NSEnumerator *)enumerator block:(id(^)(id each))block {
	if ((self = [super init])) {
		_enumerator = enumerator;
		_block = [block copy];
	}
	return self;
}


-(id)nextObject {
	return self.block([self.enumerator nextObject]);
}

@end
