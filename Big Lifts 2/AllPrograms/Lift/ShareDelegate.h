#import <Foundation/Foundation.h>

@class JWorkout;

@protocol ShareDelegate <NSObject>
- (JWorkout *)getSharedWorkout;
@end