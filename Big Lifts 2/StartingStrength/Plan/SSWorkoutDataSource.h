@class SSWorkout;

@interface SSWorkoutDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (SSWorkout *)getWorkoutForSection:(int)section;
@end