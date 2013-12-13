#import "DecimalNumberHandlers.h"

@implementation DecimalNumberHandlers

+ (NSDecimalNumberHandler *)noRaise {
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                    scale:NSDecimalNoScale
                                                                                         raiseOnExactness:NO
                                                                                          raiseOnOverflow:NO
                                                                                         raiseOnUnderflow:NO
                                                                                      raiseOnDivideByZero:NO];
}

@end