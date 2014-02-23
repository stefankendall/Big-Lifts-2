@interface DecimalNumberHelper : NSObject
+ (NSDecimalNumber *)nanTo0:(NSDecimalNumber *)number;

+ (NSDecimalNumber *)nan:(NSDecimalNumber *)number to:(NSDecimalNumber *)to;

+ (BOOL)nanOrNil:(NSDecimalNumber *)number;
@end