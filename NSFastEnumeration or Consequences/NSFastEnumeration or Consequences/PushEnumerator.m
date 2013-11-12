#import "PushEnumerator.h"

@interface PushEnumerator ()
@property (nonatomic) NSMutableArray *buffer;
@end

@implementation PushEnumerator

-(NSMutableArray *)buffer {
	return _buffer ?: (self.buffer = [NSMutableArray new]);
}

-(void)pushObject:(id)object {
	[self pushObjectsInArray:@[object]];
}

-(void)pushObjectsInArray:(NSArray *)objects {
	bool shouldNotify = self.buffer.count == 0;
	
	if (shouldNotify) [self willChangeValueForKey:@"currentObject"];
	
	[self.buffer addObjectsFromArray:objects];
	
	if (shouldNotify) [self didChangeValueForKey:@"currentObject"];
	
}

-(id)currentObject {
	return self.buffer.firstObject;
}

-(id)nextObject {
	id object = self.currentObject;
	if (self.buffer.count)
		[self.buffer removeObjectAtIndex:0];
	return object;
}

@end
