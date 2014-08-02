#import <FlurrySDK/Flurry.h>
#import "SettingsViewController.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "TextViewInputAccessoryBuilder.h"
#import "IAPAdapter.h"
#import "BLJStoreManager.h"
#import "BLKeyValueStore.h"
#import "Migrator.h"
#import "PaddingTextField.h"
#import "JBarStore.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "DecimalNumberHelper.h"
#import "JBar.h"
#import "UIViewController+PurchaseOverlay.h"
#import "Purchaser.h"

@interface SettingsViewController ()
@property(nonatomic, strong) NSArray *roundingOptions;
@property(nonatomic, strong) NSArray *roundingTypeOptions;
@end

@implementation SettingsViewController {
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRoundTo];
    [self setupRoundingType];
    [self.barWeightField setDelegate:self];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.barWeightField];

    self.iapCells = @{
            IAP_EVERYTHING : self.everythingCell
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"Settings"];
    [self reloadData];

    [self.iCloudEnabled setOn:[BLKeyValueStore iCloudEnabled]];
    [self enableDisableIap];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableDisableIap)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)enableDisableIap {
    if ([[IAPAdapter instance] hasPurchased:IAP_EVERYTHING]) {
        [self enable:self.everythingCell];
    }
    else {
        [self disable:IAP_EVERYTHING view:self.everythingCell];
    }
}

- (void)reloadData {
    JSettings *settings = [[JSettingsStore instance] first];
    NSDictionary *unitsSegments = @{@"lbs" : @0, @"kg" : @1};
    [unitsSegmentedControl setSelectedSegmentIndex:[[unitsSegments objectForKey:settings.units] integerValue]];

    NSUInteger roundToRow = [self.roundingOptions indexOfObject:settings.roundTo];
    if (roundToRow == NSNotFound) {
        roundToRow = 0;
        settings.roundTo = N(5);
    }
    [self.roundToField setText:self.roundingText[roundToRow]];
    [self.roundToPicker selectRow:roundToRow inComponent:0 animated:NO];

    NSUInteger roundingTypeRow = [self.roundingTypeOptions indexOfObject:settings.roundingType];
    if (roundingTypeRow != NSNotFound) {
        [self.roundingTypeField setText:self.roundingTypeOptions[roundingTypeRow]];
        [self.roundingTypePicker selectRow:roundingTypeRow inComponent:0 animated:NO];
    }

    [self.keepScreenOnSwitch setOn:[[[JSettingsStore instance] first] screenAlwaysOn]];
    [self.barWeightField setText:[NSString stringWithFormat:@"%@", [[[JBarStore instance] first] weight]]];
    [self.barLoadingEnabledSwitch setOn:[[[JSettingsStore instance] first] barLoadingEnabled]];
}

- (IBAction)unitsChanged:(id)sender {
    UISegmentedControl *unitsControl = sender;
    NSArray *unitsMapping = @[@"lbs", @"kg"];
    [[[JSettingsStore instance] first] setUnits:unitsMapping[(NSUInteger) [unitsControl selectedSegmentIndex]]];
    [self reloadData];
}

- (IBAction)barLoadingEnabledChanged:(id)sender {
    [[[JSettingsStore instance] first] setBarLoadingEnabled:[self.barLoadingEnabledSwitch isOn]];
}

- (IBAction)keepScreenOnChanged:(id)sender {
    [[[JSettingsStore instance] first] setScreenAlwaysOn:self.keepScreenOnSwitch.isOn];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.roundToPicker) {
        return [self.roundingOptions count];
    }
    else {
        return [self.roundingTypeOptions count];
    }
}

- (void)setupRoundTo {
    self.roundingOptions = @[N(0.5), N(1), N(2), N(2.5), N(5), [NSDecimalNumber decimalNumberWithString:(NSString *) NEAREST_5_ROUNDING]];
    self.roundingText = @[@"0.5", @"1", @"2", @"2.5", @"5", @"Nearest 5"];
    self.roundToPicker = [UIPickerView new];
    [self.roundToPicker setDataSource:self];
    [self.roundToPicker setDelegate:self];
    self.roundToField.inputView = self.roundToPicker;
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.roundToField];
}


- (void)setupRoundingType {
    self.roundingTypeOptions = @[ROUNDING_TYPE_DOWN, ROUNDING_TYPE_NORMAL, ROUNDING_TYPE_UP];
    self.roundingTypePicker = [UIPickerView new];
    [self.roundingTypePicker setDataSource:self];
    [self.roundingTypePicker setDelegate:self];
    self.roundingTypeField.inputView = self.roundingTypePicker;

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.roundingTypeField];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [UILabel new];
    if (pickerView == self.roundToPicker) {
        [label setText:self.roundingText[(NSUInteger) row]];
    }
    else {
        [label setText:self.roundingTypeOptions[(NSUInteger) row]];
    }

    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell viewWithTag:1]) {
        [self resetAllData];
    } else if ([cell viewWithTag:2]) {
        [self restorePurchases];
    } else if ([cell viewWithTag:3]) {
        [self purchaseFromCell:self.everythingCell];
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
        [[BLJStoreManager instance] resetAllStores];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    JSettings *settings = [[JSettingsStore instance] first];
    if (pickerView == self.roundToPicker) {
        settings.roundTo = self.roundingOptions[(NSUInteger) row];
    }
    else {
        settings.roundingType = self.roundingTypeOptions[(NSUInteger) row];
    }

    [self reloadData];
}

- (IBAction)iCloudValueChanged:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"Data will not transfer between local and iCloud"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:@"Cancel", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        BOOL iCloudEnabled = [self.iCloudEnabled isOn];
        [[BLJStoreManager instance] syncStores];
        [BLKeyValueStore forceICloud:iCloudEnabled];
        [[Migrator new] migrateStores];
        [[BLJStoreManager instance] loadStores];
    }
    else {
        [self.iCloudEnabled setOn:[BLKeyValueStore iCloudEnabled]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSDecimalNumber *barWeight = [DecimalNumberHelper nanTo0:
            [NSDecimalNumber decimalNumberWithString:[self.barWeightField text]
                                              locale:[NSLocale currentLocale]]];
    JBar *bar = [[JBarStore instance] first];
    [bar setWeight:barWeight];
}

@end