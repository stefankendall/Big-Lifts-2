#import "SetChangeDelegate.h"

@class JFTOWorkout;

@interface FTOLiftWorkoutViewController : UITableViewController <UITextFieldDelegate, SetChangeDelegate> {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) JFTOWorkout *ftoWorkout;

@property(nonatomic) NSNumber *tappedSetRow;

@property(nonatomic) NSMutableDictionary *variableReps;
@property(nonatomic) NSMutableDictionary *variableWeight;

- (IBAction)doneButtonTapped:(id)sender;

- (void)setWorkout:(JFTOWorkout *)ftoWorkout1;

- (BOOL)missedAmrapReps;

@end