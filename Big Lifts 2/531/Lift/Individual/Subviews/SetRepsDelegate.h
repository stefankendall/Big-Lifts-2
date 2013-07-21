#import <Foundation/Foundation.h>

@protocol SetRepsDelegate <NSObject>

- (void)repsChanged:(NSNumber *)reps;

@end