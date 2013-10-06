#import "OneRepViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "OneRepEstimator.h"

@interface OneRepViewController()
@property(nonatomic, strong) NSArray *formulaNames;
@property(nonatomic, strong) NSArray *formulaDescriptions;
@end

@implementation OneRepViewController

- (void)awakeFromNib {
    self.formulaNames = @[
            @"Epley",
            @"Brzycki"];
    self.formulaDescriptions = @[
            @"1RM = w(1 + r/30)",
            @"1RM = w(36/(37-r))"
    ];
}

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.formulaSelector];
    [self.weightField setDelegate:self];
    [self.repsField setDelegate:self];
    [self.formulaSelector setDelegate:self];

    self.formulaPicker = [UIPickerView new];
    [self.formulaPicker setDataSource:self];
    [self.formulaPicker setDelegate:self];
    self.formulaSelector.inputView = self.formulaPicker;
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
    [self updateOneRepMethod];
    [self updateMaxEstimate];
}

- (void)updateOneRepMethod {
    int row = [self.formulaPicker selectedRowInComponent:0];
    [self.formulaDescription setText:self.formulaDescriptions[(NSUInteger) row]];
}

- (void)updateMaxEstimate {
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