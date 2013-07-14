#import "UITableViewController+NoEmptyRows.h"

@interface SSWorkoutVariantController : UITableViewController {
}
@property(weak, nonatomic) IBOutlet UITableViewCell *onusWunslerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *practicalProgrammingCell;

- (void)disable:(NSString *)purchaseId;
- (void)enable:(NSString *)purchaseId;
@end