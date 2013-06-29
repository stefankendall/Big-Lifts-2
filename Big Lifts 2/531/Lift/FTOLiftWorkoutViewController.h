@class FTOWorkout;

@interface FTOLiftWorkoutViewController : UITableViewController {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) FTOWorkout *ftoWorkout;

- (IBAction)doneButtonTapped:(id)sender;

@end