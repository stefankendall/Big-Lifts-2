#import "DecimalNumberHelper.h"

@implementation DecimalNumberHelper

+ (NSDecimalNumber *) nanTo0: (NSDecimalNumber *) number {
    return [number isEqual:[NSDecimalNumber notANumber]] ? N(0) : number;
}

@end