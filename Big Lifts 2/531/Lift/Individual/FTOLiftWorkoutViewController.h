#import "SetChangeDelegate.h"

@class FTOWorkout;
@class Set;

@interface FTOLiftWorkoutViewController : UITableViewController <UITextFieldDelegate, SetChangeDelegate> {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) FTOWorkout *ftoWorkout;

@property(nonatomic) NSNumber *tappedSetRow;

@property(nonatomic) NSMutableDictionary *variableReps;
@property(nonatomic) NSMutableDictionary *variableWeight;

- (IBAction)doneButtonTapped:(id)sender;

- (void)setWorkout:(FTOWorkout *)ftoWorkout1;

- (BOOL)missedAmrapReps;

@end