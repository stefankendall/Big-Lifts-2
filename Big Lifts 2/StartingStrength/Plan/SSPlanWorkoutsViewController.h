
#import "UIViewController+ViewDeckAdditions.h"

@class SSWorkoutDataSource;

@interface SSPlanWorkoutsViewController : UIViewController <UITableViewDelegate> {
    __weak IBOutlet UITableView *workoutTableView;
}

@property(nonatomic, strong) SSWorkoutDataSource <UITableViewDataSource> *workoutDataSource;

@end