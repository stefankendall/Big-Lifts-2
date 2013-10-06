#import <Foundation/Foundation.h>

@protocol MaxEstimator <NSObject>

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps;

@end