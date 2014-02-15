#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"
#import "BLTableViewController.h"

@class PurchaseOverlay;
@class WeightTableCell;

@interface BarLoadingViewController : BLTableViewController <UIGestureRecognizerDelegate, UITableViewDelegate, UITextFieldDelegate> {
}
- (void)deleteButtonTapped:(id)deleteButton;

- (void)plateCountChanged:(UIStepper *)plateStepper;

- (void)modifyCellForPlateCount:(WeightTableCell *)cell currentPlateCount:(int)currentPlateCount;
@end