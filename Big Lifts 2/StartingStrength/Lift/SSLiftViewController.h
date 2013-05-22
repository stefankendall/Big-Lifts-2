#import "SSMiddleViewController.h"

@class SSLiftSummaryDataSource;

@interface SSLiftViewController : SSMiddleViewController {
}
@property(weak, nonatomic) IBOutlet UITableView *workoutSummaryTable;

@property(nonatomic, retain) SSLiftSummaryDataSource <UITableViewDataSource> *ssLiftSummaryDataSource;

- (IBAction)workoutValueChanged:(id)sender;
- (void) switchWorkoutToIndex: (int) index;

@end