#import "JModel.h"

@interface JSSWorkout : JModel

@property(nonatomic) NSString *name;
@property(nonatomic) NSNumber *order;
@property(nonatomic) NSMutableArray *workouts;
@property(nonatomic) NSNumber *alternation;
@end