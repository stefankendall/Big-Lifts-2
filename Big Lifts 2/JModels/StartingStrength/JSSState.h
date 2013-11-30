#import "JModel.h"

@class JSSWorkout;

@interface JSSState : JModel
@property(nonatomic) JSSWorkout *lastWorkout;
@property(nonatomic) NSNumber *workoutAAlternation;
@end