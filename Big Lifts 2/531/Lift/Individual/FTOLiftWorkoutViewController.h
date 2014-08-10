#import "SetChangeDelegate.h"
#import "TimerObserver.h"
#import "BLTableViewController.h"
#import "ShareDelegate.h"
#import "RMSwipeTableViewCell.h"

@class JFTOWorkout;

@interface FTOLiftWorkoutViewController : BLTableViewController <UITextFieldDelegate, SetChangeDelegate, TimerObserver, UIActionSheetDelegate, ShareDelegate, RMSwipeTableViewCellDelegate> {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) JFTOWorkout *ftoWorkout;

@property(nonatomic) NSNumber *tappedSetRow;

- (IBAction)doneButtonTapped:(id)sender;

- (void)setWorkout:(JFTOWorkout *)ftoWorkout1;

- (BOOL)missedAmrapReps;

@end