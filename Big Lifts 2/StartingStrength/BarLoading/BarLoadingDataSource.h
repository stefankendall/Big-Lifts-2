@class AddPlateTextFieldDelegate;
@class BarWeightTextFieldDelegate;
@class WeightTableCell;

@interface BarLoadingDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    BarWeightTextFieldDelegate *barWeightTextFieldDelegate;
    UITextField *barWeightTextField;
}
@property(nonatomic, weak) UITableView *tableView;

- (void)deleteButtonTapped:(id)deleteButton;

- (void)plateCountChanged:(UIStepper *)plateStepper;

- (void)modifyCellForPlateCount:(WeightTableCell *)cell currentPlateCount:(int)currentPlateCount;

- (BOOL)isEditing;
@end