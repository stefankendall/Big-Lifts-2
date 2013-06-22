#import "UIViewController+ViewDeckAdditions.h"

@class SSLiftSummaryDataSource;
@class SSWorkout;

@interface SSLiftViewController : UIViewController {
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *workoutSelector;
@property(weak, nonatomic) IBOutlet UITableView *workoutSummaryTable;
@property(nonatomic, strong) SSWorkout *ssWorkout;
@property(nonatomic, retain) SSLiftSummaryDataSource <UITableViewDataSource> *ssLiftSummaryDataSource;

- (IBAction)workoutValueChanged:(id)sender;
- (void) switchWorkoutToIndex: (int) index;

@end