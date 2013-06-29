@class FTOWorkout;

@interface FTOLiftWorkoutViewController : UITableViewController {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) FTOWorkout *ftoWorkout;

@end