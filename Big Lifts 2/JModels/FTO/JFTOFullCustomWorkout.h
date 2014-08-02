#import "JModel.h"

@class JWorkout;
@class JLift;
@class JFTOLift;

@interface JFTOFullCustomWorkout : JModel

@property(nonatomic) JFTOLift *lift;
@property(nonatomic) JWorkout<Optional> *workout;
@property(nonatomic) NSNumber *order;

@end