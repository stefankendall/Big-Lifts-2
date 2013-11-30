#import "OneRepViewControllerTests.h"
#import "OneRepViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "Settings.h"

@implementation OneRepViewControllerTests

- (void) testEstimatesMax {
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    [controller.weightField setText:@"300"];
    [controller.repsField setText:@"5"];
    [controller textFieldDidEndEditing: nil];
    STAssertEqualObjects([controller.maxLabel text], @"350", @"");
}

- (void) testDoesNotEstimateMaxIfOneFieldBlank {
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    [controller.weightField setText:@"300"];
    [controller.repsField setText:@""];
    [controller textFieldDidEndEditing: nil];
    STAssertEqualObjects([controller.maxLabel text], @"", @"");
}

- (void) testSwitchingPickerChangesFormulaLabelAndSavesFormulaType {
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    NSString *currentFormula = [controller.formulaDescription text];
    [controller.formulaPicker selectRow:1 inComponent:0 animated:NO];
    [controller textFieldDidEndEditing:nil];
    STAssertFalse([controller.formulaDescription.text isEqualToString:@""], @"");
    STAssertFalse([currentFormula isEqualToString:controller.formulaDescription.text], @"");
    STAssertEqualObjects([[[JSettingsStore instance] first] roundingFormula], ROUNDING_FORMULA_BRZYCKI, @"");
}

@end