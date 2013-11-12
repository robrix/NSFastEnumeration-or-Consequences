#import "Point3D.h"

@implementation Point3D {
	NSNumber *_coordinates[3];
}

-(instancetype)initWithX:(double)x Y:(double)y Z:(double)z {
	if ((self = [super init])) {
		
		_coordinates[0] = @(x);
		_coordinates[1] = @(y);
		_coordinates[2] = @(z);
		
	}
	return self;
}


-(id __unsafe_unretained const *)coordinates {
	return (id const *)_coordinates;
}


-(double)magnitude {
	double sumOfSquares = 0;
	
	for (NSNumber *coordinate in self) {
		sumOfSquares += pow(coordinate.doubleValue, 2);
	}
	
	return sqrt(sumOfSquares);
}


#pragma mark NSFastEnumeration

-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
	
	bool firstCall = state->state == 0;
	
	state->state = 1; // note that we have been called
	state->mutationsPtr = state->extra;
	state->itemsPtr = (id __unsafe_unretained *)self.coordinates;
	
	return firstCall? sizeof _coordinates / sizeof *_coordinates : 0;
	
}

@end
