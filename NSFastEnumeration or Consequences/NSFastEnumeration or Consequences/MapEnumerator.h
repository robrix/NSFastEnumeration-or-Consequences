#import <Foundation/Foundation.h>

@interface MapEnumerator : NSEnumerator

-(instancetype)initWithEnumerator:(NSEnumerator *)enumerator block:(id(^)(id each))block;

@end
