#import "OneRepViewControllerTests.h"
#import "OneRepViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "PaddingTextField.h"

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

- (void) testSavesGender {
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    JSettings *settings = [[JSettingsStore instance] first];

    [controller.maleFemaleSegment setSelectedSegmentIndex:0];
    [controller maleFemaleSegmentChanged:controller.maleFemaleSegment];
    STAssertTrue(settings.isMale, @"");

    [controller.maleFemaleSegment setSelectedSegmentIndex:1];
    [controller maleFemaleSegmentChanged:controller.maleFemaleSegment];
    STAssertFalse(settings.isMale, @"");

    settings.isMale = NO;
    [controller viewWillAppear:NO];
    STAssertEquals((int) [controller.maleFemaleSegment selectedSegmentIndex], 1, @"");

    settings.isMale = YES;
    [controller viewWillAppear:NO];
    STAssertEquals((int) [controller.maleFemaleSegment selectedSegmentIndex], 0, @"");
}

- (void) testSavesBodyweight {
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    JSettings *settings = [[JSettingsStore instance] first];
    [controller.bodyweightField setText:@"175.5"];
    [controller bodyweightChanged:controller.bodyweightField];

    STAssertEqualObjects(settings.bodyweight, N(175.5), @"");
}

- (void) testSetsBodyweightOnLoad {
    [[[JSettingsStore instance] first] setBodyweight: N(200.5)];
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    STAssertEqualObjects([controller.bodyweightField text], @"200.5", @"");
}

- (void) testHandlesEmptyBodyweight {
    STAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@""], [NSDecimalNumber notANumber], @"");
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    [controller.bodyweightField setText:@""];
    [controller bodyweightChanged:controller.bodyweightField];
}

@end