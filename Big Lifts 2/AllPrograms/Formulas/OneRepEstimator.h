@interface OneRepEstimator : NSObject

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps;

- (NSDecimalNumber *)oneDecimalPlace:(NSDecimalNumber *)number;
@end