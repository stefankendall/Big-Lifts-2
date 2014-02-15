#import "UITableViewController+NoEmptyRows.h"
#import "UIViewController+PurchaseOverlay.h"
#import "BLTableViewController.h"

extern int const SS_WORKOUT_VARIANT_SECTION;

@interface SSWorkoutVariantController : BLTableViewController {
}
@property (weak, nonatomic) IBOutlet UISwitch *warmupToggle;
@property (weak, nonatomic) IBOutlet UITableViewCell *warmupCell;
@property(weak, nonatomic) IBOutlet UITableViewCell *onusWunslerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *practicalProgrammingCell;

- (IBAction)toggleWarmup:(id)sender;
@end