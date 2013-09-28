#import "SettingsViewController.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "TextViewInputAccessoryBuilder.h"
#import "BLStoreManager.h"
#import "IAPAdapter.h"

@interface SettingsViewController ()
@property(nonatomic, strong) NSArray *roundingOptions;
@end

@implementation SettingsViewController {
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)viewDidLoad {
    [self setupRoundTo];
}

- (void)reloadData {
    Settings *settings = [[SettingsStore instance] first];
    NSDictionary *unitsSegments = @{@"lbs" : @0, @"kg" : @1};
    [unitsSegmentedControl setSelectedSegmentIndex:[[unitsSegments objectForKey:settings.units] integerValue]];
    [self.roundToField setText:[settings.roundTo stringValue]];
}

- (IBAction)unitsChanged:(id)sender {
    UISegmentedControl *unitsControl = sender;
    NSArray *unitsMapping = @[@"lbs", @"kg"];
    [[[SettingsStore instance] first] setUnits:unitsMapping[(NSUInteger) [unitsControl selectedSegmentIndex]]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.roundingOptions count];
}

- (void)setupRoundTo {
    self.roundingOptions = @[@"1", @"2.5", @"5"];
    self.roundToPicker = [UIPickerView new];
    [self.roundToPicker setDataSource:self];
    [self.roundToPicker setDelegate:self];
    self.roundToField.inputView = self.roundToPicker;
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.roundToField];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [UILabel new];
    [label setText:self.roundingOptions[(NSUInteger) row]];
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
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *newRoundingOption = self.roundingOptions[(NSUInteger) row];
    Settings *settings = [[SettingsStore instance] first];
    settings.roundTo = [NSDecimalNumber decimalNumberWithString:newRoundingOption];
    [self reloadData];
}

@end