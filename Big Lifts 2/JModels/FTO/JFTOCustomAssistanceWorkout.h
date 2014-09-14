#import "JModel.h"

@class JLift;
@class JFTOLift;
@class JWorkout;

@interface JFTOCustomAssistanceWorkout : JModel

@property(nonatomic, strong) JFTOLift<Optional> *mainLift;
@property(nonatomic, strong) JWorkout<Optional> *workout;
@end