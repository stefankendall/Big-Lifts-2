#import "UITableViewController+NoEmptyRows.h"

@interface SSWorkoutVariantController : UITableViewController {
}
@property(weak, nonatomic) IBOutlet UITableViewCell *onusWunslerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *practicalProgrammingCell;

- (void)disable:(UITableViewCell *)cell;
- (void)enable:(UITableViewCell *)cell;
@end