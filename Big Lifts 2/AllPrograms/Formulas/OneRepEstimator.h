@interface OneRepEstimator : NSObject

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps;

@end