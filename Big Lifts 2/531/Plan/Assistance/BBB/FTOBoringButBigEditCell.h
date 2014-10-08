@class PaddingRowTextField;

@interface FTOBoringButBigEditCell : UITableViewCell <UIPickerViewDelegate, UIPickerViewDataSource>

@property(weak, nonatomic) IBOutlet UILabel *forLift;
@property(weak, nonatomic) IBOutlet PaddingRowTextField *useLift;
@property(nonatomic, strong) UIPickerView *liftPicker;
@end