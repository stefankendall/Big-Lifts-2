#import "FTOBoringButBigEditCell.h"
#import "PaddingTextField.h"
#import "JFTOLift.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JFTOLiftStore.h"
#import "PaddingRowTextField.h"

@implementation FTOBoringButBigEditCell

- (void)awakeFromNib {
    self.liftPicker = [UIPickerView new];
    self.useLift.inputView = self.liftPicker;
    [self.liftPicker setDataSource:self];
    [self.liftPicker setDelegate:self];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.useLift];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[JFTOLiftStore instance] count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    JFTOLift *ftoLift = [[JFTOLiftStore instance] atIndex:row];
    UILabel *label = [UILabel new];
    [label setText:ftoLift.name];
    return label;
}

@end