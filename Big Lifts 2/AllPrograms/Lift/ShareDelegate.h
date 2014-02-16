#import <Foundation/Foundation.h>

@class JWorkout;

@protocol ShareDelegate <NSObject>
- (NSArray *)getSharedWorkout;
@end