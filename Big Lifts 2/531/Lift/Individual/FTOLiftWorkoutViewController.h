#import "AmrapDelegate.h"

@class FTOWorkout;

@interface FTOLiftWorkoutViewController : UITableViewController <UITextFieldDelegate, AmrapDelegate> {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) FTOWorkout *ftoWorkout;

- (IBAction)doneButtonTapped:(id)sender;

@end