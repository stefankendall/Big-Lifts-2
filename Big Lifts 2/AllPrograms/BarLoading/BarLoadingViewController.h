#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class PurchaseOverlay;
@class WeightTableCell;

@interface BarLoadingViewController : UITableViewController <UIGestureRecognizerDelegate, UITableViewDelegate, UITextFieldDelegate> {
}
- (void)deleteButtonTapped:(id)deleteButton;

- (void)plateCountChanged:(UIStepper *)plateStepper;

- (void)modifyCellForPlateCount:(WeightTableCell *)cell currentPlateCount:(int)currentPlateCount;
@end