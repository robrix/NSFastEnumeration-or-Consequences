//  DoubleArray.m
//  Created by Rob Rix on 11/12/2013.
//  Copyright (c) 2013 Rob Rix. All rights reserved.

#import "DoubleArray.h"

@interface DoubleArray ()
@property (nonatomic) NSMutableArray *numbers;
@end

@implementation DoubleArray

-(NSMutableArray *)numbers {
	return _numbers ?: (self.numbers = [NSMutableArray new]);
}


-(NSUInteger)count {
	return self.numbers.count;
}

-(void)addDouble:(double)number {
	[self.numbers addObject:@(number)];
}


#pragma mark NSFastEnumeration

-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
	
	return [self.numbers countByEnumeratingWithState:state objects:buffer count:len];
	
}

@end
