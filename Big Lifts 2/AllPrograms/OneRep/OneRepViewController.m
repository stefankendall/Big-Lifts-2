#import "OneRepViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "OneRepEstimator.h"

@interface OneRepViewController()
@property(nonatomic, strong) NSArray *formulaNames;
@end

@implementation OneRepViewController

- (void)awakeFromNib {
    self.formulaNames = @[@"Epley", @"Brzycki"];
}

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.formulaSelector];
    [self.weightField setDelegate:self];
    [self.repsField setDelegate:self];
    UIPickerView *formulaPicker = [UIPickerView new];
    [formulaPicker setDataSource:self];
    [formulaPicker setDelegate:self];
    self.formulaSelector.inputView = formulaPicker;
    [self.formulaSelector setText:[self pickerView:nil titleForRow:0 forComponent:0]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.formulaNames count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.formulaNames[(NSUInteger) row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *title = [self pickerView:pickerView titleForRow:row forComponent:component];
    [self.formulaSelector setText:title];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:[self.weightField text]];
    int reps = [[self.repsField text] intValue];
    NSDecimalNumber *estimate = [[OneRepEstimator new] estimate:weight withReps:reps];
    if ([estimate compare:N(0)] == NSOrderedDescending) {
        [self.maxLabel setText:[estimate stringValue]];
    }
    else {
        [self.maxLabel setText:@""];
    }
}

@end