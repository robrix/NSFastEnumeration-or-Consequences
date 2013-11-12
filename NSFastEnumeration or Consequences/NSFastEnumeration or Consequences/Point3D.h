#import <Foundation/Foundation.h>

@interface Point3D : NSObject <NSFastEnumeration>

-(instancetype)initWithX:(double)x Y:(double)y Z:(double)z;

@property (nonatomic, readonly) double magnitude;

@end
