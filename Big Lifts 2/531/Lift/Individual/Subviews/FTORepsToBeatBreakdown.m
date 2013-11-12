#import "FTORepsToBeatBreakdown.h"
#import "FTORepsToBeatCalculator.h"
#import "Set.h"
#import "OneRepEstimator.h"
#import "Lift.h"
#import "PaddingTextField.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTORepsToBeatBreakdown

- (void)viewDidLoad {
    self.configOptions = @[@"Use Everything", @"Log Only"];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.configTextField];
    [self.configTextField setDelegate:self];
    self.configPicker = [UIPickerView new];
    [self.configPicker setDataSource:self];
    [self.configPicker setDelegate:self];
    self.configTextField.inputView = self.configPicker;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.enteredOneRepMax setText:[self.lastSet.lift.weight stringValue]];
    NSDecimalNumber *logMax = [[FTORepsToBeatCalculator new] findLogMax:(id) self.lastSet.lift];
    [self.maxFromLog setText:[logMax stringValue]];

    NSDecimalNumber *lastSetWeight = [self.lastSet roundedEffectiveWeight];
    int minimumReps = [[FTORepsToBeatCalculator new] repsToBeat:(id) self.lastSet.lift atWeight:lastSetWeight];
    [self.reps setText:[NSString stringWithFormat:@"%dx", minimumReps]];
    [self.weight setText:[lastSetWeight stringValue]];

    NSDecimalNumber *estimatedMax = [[OneRepEstimator new] estimate:lastSetWeight withReps:minimumReps];
    [self.estimatedMax setText:[estimatedMax stringValue]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.configOptions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.configOptions[(NSUInteger) row];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.configTextField setText:self.configOptions[(NSUInteger) [self.configPicker selectedRowInComponent:0]]];
}

@end