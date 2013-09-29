#import "UITableViewController+NoEmptyRows.h"
#import "UIViewController+PurchaseOverlay.h"

extern int const SS_WORKOUT_VARIANT_SECTION;

@interface SSWorkoutVariantController : UITableViewController {
}
@property (weak, nonatomic) IBOutlet UITableViewCell *warmupCell;
@property(weak, nonatomic) IBOutlet UITableViewCell *onusWunslerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *practicalProgrammingCell;
@end