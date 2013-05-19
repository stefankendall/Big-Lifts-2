#import "SSMiddleViewController.h"

@class SSWorkoutDataSource;

@interface SSPlanWorkoutsViewController : SSMiddleViewController <UITableViewDelegate> {
    __weak IBOutlet UITableView *workoutATableView;
    __weak IBOutlet UITableView *workoutBTableView;
}

@property(nonatomic, strong) SSWorkoutDataSource <UITableViewDataSource> *workoutADataSource;
@property(nonatomic, strong) SSWorkoutDataSource <UITableViewDataSource> *workoutBDataSource;

@end