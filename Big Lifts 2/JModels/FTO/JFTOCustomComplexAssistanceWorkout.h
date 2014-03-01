#import "JModel.h"

@class JWorkout;
@class JFTOLift;

@interface JFTOCustomComplexAssistanceWorkout : JModel

@property(nonatomic, strong) JFTOLift *mainLift;
@property(nonatomic, strong) NSNumber *week;
@property(nonatomic, strong) JWorkout *workout;

@end