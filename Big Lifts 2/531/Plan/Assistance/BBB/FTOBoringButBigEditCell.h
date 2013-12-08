#import "CTCustomTableViewCell/CTCustomTableViewCell.h"

@class PaddingRowTextField;

@interface FTOBoringButBigEditCell : CTCustomTableViewCell <UIPickerViewDelegate, UIPickerViewDataSource> {
}

@property(weak, nonatomic) IBOutlet UILabel *forLift;
@property(weak, nonatomic) IBOutlet PaddingRowTextField *useLift;
@property(nonatomic, strong) UIPickerView *liftPicker;
@end