@class AddPlateTextFieldDelegate;
@class BarWeightTextFieldDelegate;

@interface WeightsTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    BarWeightTextFieldDelegate *barWeightTextFieldDelegate;
    UITextField *barWeightTextField;
}
@property(nonatomic, weak) UITableView *tableView;

- (void)plateCountChanged:(UIStepper *)plateStepper;

- (BOOL)isEditing;
@end