#import "JModel.h"

@class JWorkout;
@class JLift;
@class JFTOLift;

@interface JFTOFullCustomWorkout : JModel

@property(nonatomic) JFTOLift *lift;
@property(nonatomic) JWorkout *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic) BOOL deload;
@property(nonatomic) BOOL incrementAfterWeek;
@property(nonatomic) NSNumber *order;

@end