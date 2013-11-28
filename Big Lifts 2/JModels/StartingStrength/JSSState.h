#import "JSONModel/JSONModel.h"

@class JSSWorkout;

@interface JSSState : JSONModel
@property(nonatomic) JSSWorkout *lastWorkout;
@property(nonatomic) NSNumber *workoutAAlternation;
@end