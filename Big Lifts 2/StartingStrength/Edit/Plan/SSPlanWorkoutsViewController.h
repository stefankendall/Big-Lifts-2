#import "SSMiddleViewController.h"

@class SSWorkoutDataSource;

@interface SSPlanWorkoutsViewController : SSMiddleViewController <UITableViewDelegate> {
    __weak IBOutlet UITableView *workoutTableView;
}

@property(nonatomic, strong) SSWorkoutDataSource <UITableViewDataSource> *workoutDataSource;

@end