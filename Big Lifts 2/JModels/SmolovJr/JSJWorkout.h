#import "JModel.h"

@class JWorkout;

@interface JSJWorkout : JModel

@property(nonatomic) JWorkout *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic) BOOL done;

@property(nonatomic) NSDecimalNumber *minWeightAdd;
@property(nonatomic) NSDecimalNumber *maxWeightAdd;
@end