#import "FTOCustomAssistanceEditSetViewController.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JSet.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "PaddingTextField.h"
#import "JFTOCustomAssistanceLift.h"

@implementation FTOCustomAssistanceEditSetViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.liftTextField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.percentageTextField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.repsTextField];
    [self.liftTextField setDelegate:self];
    [self.percentageTextField setDelegate:self];
    [self.repsTextField setDelegate:self];

    self.liftsPicker = [UIPickerView new];
    [self.liftsPicker setDataSource:self];
    [self.liftsPicker setDelegate:self];
    self.liftTextField.inputView = self.liftsPicker;
}

- (void)viewWillAppear:(BOOL)animated {
    BOOL hasLifts = [[JFTOCustomAssistanceLiftStore instance] count] > 0;
    [self.addLiftButton setHidden:hasLifts];
    [self.liftTextField setHidden:!hasLifts];

    if (self.set.lift) {
        [self.liftTextField setText:self.set.lift.name];
        [self.liftsPicker selectRow:[[[JFTOCustomAssistanceLiftStore instance] findAll] indexOfObject:self.set.lift] inComponent:0 animated:NO];
    }
    [self.percentageTextField setText:[self.set.percentage stringValue]];
    [self.repsTextField setText:[self.set.reps stringValue]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateSet];
}

- (void)updateSet {
    self.set.lift = [[JFTOCustomAssistanceLiftStore instance] atIndex:[self.liftsPicker selectedRowInComponent:0]];
    self.set.percentage = [NSDecimalNumber decimalNumberWithString:[self.percentageTextField text]];
    self.set.reps = [NSNumber numberWithInt:[[self.repsTextField text] intValue]];
    [self.liftTextField setText:self.set.lift.name];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ftoCustomAsstEditSetAddLift"]) {
        self.set.lift = [[JFTOCustomAssistanceLiftStore instance] create];
        FTOCustomAssistanceEditLiftViewController *controller = [segue destinationViewController];
        controller.lift = (id) self.set.lift;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[JFTOCustomAssistanceLiftStore instance] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    JFTOCustomAssistanceLift *lift = [[JFTOCustomAssistanceLiftStore instance] atIndex:row];
    return lift.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self updateSet];
}

@end