#import "SetChangeDelegate.h"
#import "TimerObserver.h"
#import "BLTableViewController.h"
#import "ShareDelegate.h"
#import "RMSwipeTableViewCell.h"
#import <iAd/iAd.h>

@class JFTOWorkout;

@interface FTOLiftWorkoutViewController : BLTableViewController <UITextFieldDelegate, SetChangeDelegate, TimerObserver, UIActionSheetDelegate, ShareDelegate, RMSwipeTableViewCellDelegate, ADInterstitialAdDelegate> {
}
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property(nonatomic, strong) JFTOWorkout *ftoWorkout;

@property(nonatomic) NSNumber *tappedSetRow;

@property(nonatomic, strong) ADInterstitialAd *interstitial;

@property(nonatomic) BOOL upSellMade;

- (IBAction)doneButtonTapped:(id)sender;

- (void)setWorkout:(JFTOWorkout *)ftoWorkout1;

- (BOOL)missedAmrapReps;

@end