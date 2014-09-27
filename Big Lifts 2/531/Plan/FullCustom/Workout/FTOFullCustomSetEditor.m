#import <FlurrySDK/Flurry.h>
#import "FTOFullCustomSetEditor.h"
#import "JSet.h"
#import "PaddingTextField.h"
#import "DecimalNumberHelper.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JLift.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"

@implementation FTOFullCustomSetEditor

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"5/3/1_FullCustom_SetEditor"];

    [self.lift setText:self.set.lift.name];
    [self.reps setText:[NSString stringWithFormat:@"%@", self.set.reps]];
    [self.percentage setText:[NSString stringWithFormat:@"%@", self.set.percentage]];
    [self.amrapSwitch setOn:self.set.amrap];
    [self.warmupSwitch setOn:self.set.warmup];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.reps setDelegate:self];
    [self.percentage setDelegate:self];
    [self.lift setDelegate:self];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.reps];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.percentage];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.lift];

    [self.amrapSwitch addTarget:self action:@selector(valuesChanged:) forControlEvents:UIControlEventValueChanged];
    [self.warmupSwitch addTarget:self action:@selector(valuesChanged:) forControlEvents:UIControlEventValueChanged];

    self.liftsPicker = [UIPickerView new];
    [self.liftsPicker setDataSource:self];
    [self.liftsPicker setDelegate:self];
    int row = [[[JFTOLiftStore instance] findAll] indexOfObject:self.set.lift];
    if (row == NSNotFound) {
        row = 0;
    }

    [self.liftsPicker selectRow:row inComponent:0 animated:NO];
    self.lift.inputView = self.liftsPicker;
}

- (void)valuesChanged:(id)valuesChanged {
    self.set.reps = [NSNumber numberWithInt:[[self.reps text] intValue]];
    self.set.percentage = [DecimalNumberHelper nanTo0:[NSDecimalNumber decimalNumberWithString:[self.percentage text]]];
    self.set.amrap = [self.amrapSwitch isOn];
    self.set.warmup = [self.warmupSwitch isOn];
    self.set.lift = [self selectedLift];

    [self.lift setText:self.set.lift.name];
}

- (JLift *)selectedLift {
    return [[JFTOLiftStore instance] atIndex:[self.liftsPicker selectedRowInComponent:0]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self valuesChanged:textField];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[JFTOLiftStore instance] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    JFTOLift *ftoLift = [[JFTOLiftStore instance] atIndex:row];
    return ftoLift.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self valuesChanged:nil];
}

@end