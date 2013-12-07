#import "SettingsViewController.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "TextViewInputAccessoryBuilder.h"
#import "BLStoreManager.h"
#import "IAPAdapter.h"
#import "BLJStoreManager.h"

@interface SettingsViewController ()
@property(nonatomic, strong) NSArray *roundingOptions;
@end

@implementation SettingsViewController {
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadData];
}

- (void)viewDidLoad {
    [self setupRoundTo];
}

- (void)reloadData {
    JSettings *settings = [[JSettingsStore instance] first];
    NSDictionary *unitsSegments = @{@"lbs" : @0, @"kg" : @1};
    [unitsSegmentedControl setSelectedSegmentIndex:[[unitsSegments objectForKey:settings.units] integerValue]];

    NSUInteger roundingRow = [self.roundingOptions indexOfObject:settings.roundTo];
    [self.roundToField setText:self.roundingText[roundingRow]];
    [self.roundToPicker selectRow:roundingRow inComponent:0 animated:NO];
    [self.keepScreenOnSwitch setOn:[[[JSettingsStore instance] first] screenAlwaysOn]];
}

- (IBAction)unitsChanged:(id)sender {
    UISegmentedControl *unitsControl = sender;
    NSArray *unitsMapping = @[@"lbs", @"kg"];
    [[[JSettingsStore instance] first] setUnits:unitsMapping[(NSUInteger) [unitsControl selectedSegmentIndex]]];
}

- (IBAction)keepScreenOnChanged:(id)sender {
    [[[JSettingsStore instance] first] setScreenAlwaysOn: self.keepScreenOnSwitch.isOn];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.roundingOptions count];
}

- (void)setupRoundTo {
    self.roundingOptions = @[N(1), N(2.5), N(5), [NSDecimalNumber decimalNumberWithString:(NSString *) NEAREST_5_ROUNDING]];
    self.roundingText = @[@"1", @"2.5", @"5", @"Nearest 5"];
    self.roundToPicker = [UIPickerView new];
    [self.roundToPicker setDataSource:self];
    [self.roundToPicker setDelegate:self];
    self.roundToField.inputView = self.roundToPicker;
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.roundToField];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [UILabel new];
    [label setText:self.roundingText[(NSUInteger) row]];
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell viewWithTag:1]) {
        [self resetAllData];
    } else if ([cell viewWithTag:2]) {
        [self restorePurchases];
    }
}

- (void)restorePurchases {
    [[IAPAdapter instance] restorePurchasesWithCompletion:^{
        UIAlertView *alertView = [[UIAlertView alloc]
                initWithTitle:@""
                      message:@"Purchases Restored!"
                     delegate:nil
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)resetAllData {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:@"Reset All"
                                              otherButtonTitles:nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [[BLStoreManager instance] resetAllStores];
        [[BLJStoreManager instance] resetAllStores];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    JSettings *settings = [[JSettingsStore instance] first];
    settings.roundTo = self.roundingOptions[(NSUInteger) row];
    [self reloadData];
}

@end