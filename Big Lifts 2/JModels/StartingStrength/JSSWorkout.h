#import "JModel.h"

@protocol JWorkout;

@interface JSSWorkout : JModel

@property(nonatomic) NSString *name;
@property(nonatomic) NSNumber *order;
@property(nonatomic) NSMutableArray<JWorkout> *workouts;
@property(nonatomic) NSNumber *alternation;
@end