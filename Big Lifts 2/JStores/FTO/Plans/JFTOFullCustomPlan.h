#import "JFTOPlan.h"

@class JFTOFullCustomWorkout;
@class JFTOFullCustomWeek;

@interface JFTOFullCustomPlan : NSObject<JFTOPlan>
- (JFTOFullCustomWorkout *)workoutForLift:(JLift *)lift inWeek:(JFTOFullCustomWeek *)week;
@end