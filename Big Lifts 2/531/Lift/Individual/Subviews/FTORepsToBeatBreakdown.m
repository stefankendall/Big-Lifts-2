#import "FTORepsToBeatBreakdown.h"
#import "FTORepsToBeatCalculator.h"
#import "OneRepEstimator.h"
#import "PaddingTextField.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JFTOSettingsStore.h"
#import "JSet.h"
#import "JLift.h"
#import "FTOSettings.h"
#import "JFTOSettings.h"

@implementation FTORepsToBeatBreakdown

- (void)viewDidLoad {
    self.configOptions = @{
            [NSNumber numberWithInt:kRepsToBeatEverything] : @"Use Everything",
            [NSNumber numberWithInt:kRepsToBeatLogOnly] : @"Log Only"
    };

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.configTextField];
    [self.configTextField setDelegate:self];
    self.configPicker = [UIPickerView new];
    [self.configPicker setDataSource:self];
    [self.configPicker setDelegate:self];
    self.configTextField.inputView = self.configPicker;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.enteredOneRepMax setText:[self.lastSet.lift.weight stringValue]];
    NSDecimalNumber *logMax = [[FTORepsToBeatCalculator new] findLogMax:(id) self.lastSet.lift];
    [self.maxFromLog setText:[logMax stringValue]];

    [self setBreakdownLabels];

    NSNumber *repsToBeatConfig = [[[JFTOSettingsStore instance] first] repsToBeatConfig];
    [self.configPicker selectRow:[repsToBeatConfig integerValue] inComponent:0 animated:NO];
    [self.configTextField setText:self.configOptions[repsToBeatConfig]];
}

- (void)setBreakdownLabels {
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
    return self.configOptions[[NSNumber numberWithInt:row]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSNumber *repsToBeatConfig = [NSNumber numberWithInt:[self.configPicker selectedRowInComponent:0]];
    [[[JFTOSettingsStore instance] first] setRepsToBeatConfig:repsToBeatConfig];
    [self.configTextField setText:self.configOptions[repsToBeatConfig]];

    [self setBreakdownLabels];
}

@end