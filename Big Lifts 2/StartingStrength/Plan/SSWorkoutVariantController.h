#import "UITableViewController+NoEmptyRows.h"

@interface SSWorkoutVariantController : UITableViewController {
}
@property(weak, nonatomic) IBOutlet UITableViewCell *onusWunslerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *practicalProgrammingCell;

- (void)disable:(NSString *)purchaseId cell:(id)cell;

- (void)enable:(UITableViewCell *)cell;

- (void)enable:(NSString *)purchaseId cell:(id)cell;
@end