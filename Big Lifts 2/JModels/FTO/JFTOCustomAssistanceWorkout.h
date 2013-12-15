#import "JModel.h"

@class JLift;
@class JFTOLift;
@class JWorkout;

@interface JFTOCustomAssistanceWorkout : JModel

@property(nonatomic, strong) JFTOLift *mainLift;
@property(nonatomic, strong) JWorkout *workout;
@end