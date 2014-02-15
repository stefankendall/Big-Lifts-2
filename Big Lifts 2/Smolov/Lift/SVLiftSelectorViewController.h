#import "UIViewController+ViewDeckAdditions.h"
#import "BLTableViewController.h"

@class JSVWorkout;

@interface SVLiftSelectorViewController : BLTableViewController
@property(nonatomic, strong) JSVWorkout *selectedWorkout;
@end