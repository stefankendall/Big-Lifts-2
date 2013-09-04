#import "SetRepsDelegate.h"

@class FTOWorkout;
@class Set;

@interface FTOLiftWorkoutViewController : UITableViewController <UITextFieldDelegate, SetRepsDelegate> {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) FTOWorkout *ftoWorkout;

@property(nonatomic) NSNumber * tappedSetRow;

@property(nonatomic) NSMutableDictionary *variableReps;

- (Set *)heaviestAmrapSet:(NSMutableOrderedSet *)sets;

- (IBAction)doneButtonTapped:(id)sender;

- (void) setWorkout: (FTOWorkout *) ftoWorkout1;

- (BOOL) missedAmrapReps;

@end