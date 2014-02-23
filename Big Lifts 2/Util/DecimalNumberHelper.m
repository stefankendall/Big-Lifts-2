#import "DecimalNumberHelper.h"

@implementation DecimalNumberHelper

+ (NSDecimalNumber *)nanTo0:(NSDecimalNumber *)number {
    return [number isEqual:[NSDecimalNumber notANumber]] ? N(0) : number;
}

+ (NSDecimalNumber *)nan:(NSDecimalNumber *)number to:(NSDecimalNumber *)to {
    return [number isEqual:[NSDecimalNumber notANumber]] ? to : number;
}

+ (BOOL)nanOrNil:(NSDecimalNumber *)number {
    return number == nil || [number isEqual:[NSDecimalNumber notANumber]];
}

@end