#import "SSMiddleViewController.h"

@class SSLiftSummaryDataSource;

@interface SSLiftViewController : SSMiddleViewController {
}
@property(weak, nonatomic) IBOutlet UITableView *workoutSummaryTable;
@property(weak, nonatomic) IBOutlet UISegmentedControl *workoutSelector;

@property(nonatomic, retain) SSLiftSummaryDataSource <UITableViewDataSource> *ssLiftSummaryDataSource;

@end