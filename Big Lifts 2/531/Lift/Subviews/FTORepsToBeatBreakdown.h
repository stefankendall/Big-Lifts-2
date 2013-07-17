@class Set;

@interface FTORepsToBeatBreakdown : UITableViewController {
}
@property(weak, nonatomic) IBOutlet UILabel *enteredOneRepMax;
@property(weak, nonatomic) IBOutlet UILabel *maxFromLog;
@property(weak, nonatomic) IBOutlet UILabel *reps;
@property(weak, nonatomic) IBOutlet UILabel *weight;
@property(weak, nonatomic) IBOutlet UILabel *estimatedMax;

@property(nonatomic, strong) Set *lastSet;
@end