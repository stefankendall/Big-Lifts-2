#import "JModel.h"

@class JSSWorkout;

@interface JSSState : JModel
@property(nonatomic) JSSWorkout<Optional> *lastWorkout;
@property(nonatomic) NSNumber *workoutAAlternation;
@end