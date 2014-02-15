#import "UIViewController+ViewDeckAdditions.h"
#import "BLTableViewController.h"

@class RateDialog;

@interface FTOLiftViewController : BLTableViewController
@property(nonatomic, strong) RateDialog *rateDialog;
@end