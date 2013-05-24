@class SSWorkout;

@interface SSWorkoutLiftDataSource : NSObject <UITableViewDataSource>
@property(nonatomic, strong) SSWorkout *ssWorkout;
@property(nonatomic) int workoutIndex;

- (id)initWithSsWorkout:(SSWorkout *)ssWorkout;
@end