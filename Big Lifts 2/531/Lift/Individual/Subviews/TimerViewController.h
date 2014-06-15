#import "BLTableViewController.h"

@class PaddingTextField;

@interface TimerViewController : BLTableViewController {
}
@property(weak, nonatomic) IBOutlet PaddingTextField *restMinutes;
@property(weak, nonatomic) IBOutlet PaddingTextField *restSeconds;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startStopButton;

@end