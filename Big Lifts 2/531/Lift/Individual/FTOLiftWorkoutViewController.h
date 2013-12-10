#import "SetChangeDelegate.h"
#import "TimerProtocol.h"
#import "TimerObserver.h"

@class JFTOWorkout;

@interface FTOLiftWorkoutViewController : UITableViewController <UITextFieldDelegate, SetChangeDelegate, TimerProtocol, TimerObserver> {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) JFTOWorkout *ftoWorkout;

@property(nonatomic) NSNumber *tappedSetRow;

@property(nonatomic) NSMutableDictionary *variableReps;
@property(nonatomic) NSMutableDictionary *variableWeight;

@property(nonatomic, strong) UIButton *timerButton;

- (IBAction)doneButtonTapped:(id)sender;

- (void)setWorkout:(JFTOWorkout *)ftoWorkout1;

- (BOOL)missedAmrapReps;

@end