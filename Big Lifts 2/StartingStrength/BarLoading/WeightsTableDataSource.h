@class AddPlateTextFieldDelegate;
@class BarWeightTextFieldDelegate;

@interface WeightsTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    BOOL addingPlate;
    AddPlateTextFieldDelegate *addPlateTextFieldDelegate;
    BarWeightTextFieldDelegate *barWeightTextFieldDelegate;

    UITextField *barWeightTextField;
    UITextField *addPlateTextField;
}
@property(nonatomic, weak) UITableView *tableView;

- (void)plateCountChanged:(UIStepper *)plateStepper;

- (BOOL)isEditing;
@end