#import <FlurrySDK/Flurry.h>
#import "OneRepViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "OneRepEstimator.h"
#import "JSettings.h"
#import "JSettingsStore.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "UIViewController+PurchaseOverlay.h"
#import "PurchaseOverlay.h"
#import "PaddingTextField.h"
#import "WilksCoefficientCalculator.h"

@interface OneRepViewController ()
@property(nonatomic, strong) NSArray *formulaNames;
@property(nonatomic, strong) NSArray *formulaDescriptions;
@end

@implementation OneRepViewController

- (void)awakeFromNib {
    self.formulaNames = @[
            ROUNDING_FORMULA_EPLEY,
            ROUNDING_FORMULA_BRZYCKI
    ];
    self.formulaDescriptions = @[
            @"1RM = w(1 + r/30)",
            @"1RM = w(36/(37-r))"
    ];
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"OneRepEstimation"];
    JSettings *settings = [[JSettingsStore instance] first];
    NSString *roundingFormula = [settings roundingFormula];
    NSUInteger row = [self.formulaNames indexOfObject:roundingFormula];
    [self.formulaPicker selectRow:row inComponent:0 animated:NO];
    [self updatePickerDisplayForRow:row];
    [self.maleFemaleSegment setSelectedSegmentIndex:[settings isMale] ? 0 : 1];
    [self.bodyweightField setText:[[settings bodyweight] stringValue]];
    [self handleIapChange];
}

- (void)handleIapChange {
    if (([[IAPAdapter instance] hasPurchased:IAP_1RM])) {
        [self.view removeGestureRecognizer:[self.view.gestureRecognizers lastObject]];
        [[self.tableView viewWithTag:kPurchaseOverlayTag] removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.formulaSelector];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.bodyweightField];
    [self.weightField setDelegate:self];
    [self.repsField setDelegate:self];
    [self.formulaSelector setDelegate:self];

    self.formulaPicker = [UIPickerView new];
    [self.formulaPicker setDataSource:self];
    [self.formulaPicker setDelegate:self];
    self.formulaSelector.inputView = self.formulaPicker;
    [self.formulaSelector setText:[self pickerView:nil titleForRow:0 forComponent:0]];

    if (!([[IAPAdapter instance] hasPurchased:IAP_1RM])) {
        [self disableFullScreen:IAP_1RM view:self.view withDescription:@"Get max estimates any time\nyou log a set during a workout"];
    }

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleIapChange)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tgr {
    if ([self.tableView viewWithTag:kPurchaseOverlayTag]) {
        [[Purchaser new] purchase:IAP_1RM];
    }
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
    [self updateOneRepMethod];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateOneRepMethod];
}

- (void)updateOneRepMethod {
    int row = [self.formulaPicker selectedRowInComponent:0];
    [[[JSettingsStore instance] first] setRoundingFormula:self.formulaNames[(NSUInteger) row]];
    [self updatePickerDisplayForRow:row];
    [self updateMaxEstimate];
}

- (void)updatePickerDisplayForRow:(NSInteger)row {
    NSString *title = [self pickerView:self.formulaPicker titleForRow:row forComponent:0];
    [self.formulaSelector setText:title];
    [self.formulaDescription setText:self.formulaDescriptions[(NSUInteger) row]];
}

- (void)updateMaxEstimate {
    NSDecimalNumber *estimate = [self getMaxEstimate];
    if ([estimate compare:N(0)] == NSOrderedDescending) {
        [self.maxLabel setText:[estimate stringValue]];
    }
    else {
        [self.maxLabel setText:@""];
    }
    [self updateWilksCoefficient];
}

- (NSDecimalNumber *)getMaxEstimate {
    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:[self.weightField text] locale:NSLocale.currentLocale];
    int reps = [[self.repsField text] intValue];
    NSDecimalNumber *estimate = [[OneRepEstimator new] estimate:weight withReps:reps];
    return estimate;
}

- (IBAction)maleFemaleSegmentChanged:(id)sender {
    BOOL isMale = [self.maleFemaleSegment selectedSegmentIndex] == 0;
    [[[JSettingsStore instance] first] setIsMale:isMale];
    [self updateWilksCoefficient];
}

- (IBAction)bodyweightChanged:(id)sender {
    NSDecimalNumber *bodyweight = [NSDecimalNumber decimalNumberWithString:[self.bodyweightField text] locale:[NSLocale currentLocale]];
    if([bodyweight isEqual:[NSDecimalNumber notANumber]]){
        bodyweight = N(0);
    }

    [[[JSettingsStore instance] first] setBodyweight:bodyweight];
    [self updateWilksCoefficient];
}

- (void)updateWilksCoefficient {
    JSettings *settings = [[JSettingsStore instance] first];
    NSDecimalNumber *wilks =
            [WilksCoefficientCalculator calculate:[self getMaxEstimate]
                                   withBodyweight:settings.bodyweight
                                           isMale:settings.isMale
                                        withUnits:[settings units]];

    [self.wilksCoefficient setText:[wilks stringValue]];
}

@end