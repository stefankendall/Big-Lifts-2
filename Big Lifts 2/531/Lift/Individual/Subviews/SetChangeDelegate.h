#import <Foundation/Foundation.h>

@protocol
SetChangeDelegate <NSObject>

- (void)repsChanged:(NSNumber *)reps;

- (void)weightChanged:(NSDecimalNumber *)weight;

@end