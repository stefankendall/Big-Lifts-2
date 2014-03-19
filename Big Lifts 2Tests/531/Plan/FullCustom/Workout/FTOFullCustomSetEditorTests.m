#import "FTOFullCustomSetEditorTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOFullCustomSetEditor.h"
#import "JSetStore.h"
#import "JSet.h"
#import "PaddingTextField.h"

@implementation FTOFullCustomSetEditorTests

- (void)testSetsDataOnLoad {
    FTOFullCustomSetEditor *editor = [self getControllerByStoryboardIdentifier:@"ftoFullCustomSetEditor"];
    JSet *set = [[JSetStore instance] create];
    set.reps = @4;
    set.percentage = N(75.5);
    set.amrap = YES;
    set.warmup = NO;
    [editor setSet:set];
    [editor viewWillAppear:NO];

    STAssertEqualObjects([editor.reps text], @"4", @"");
    STAssertEqualObjects([editor.percentage text], @"75.5", @"");
    STAssertTrue([[editor amrapSwitch] isOn], @"");
    STAssertFalse([[editor warmupSwitch] isOn], @"");
}

- (void)testCanChangeSetData {
    FTOFullCustomSetEditor *editor = [self getControllerByStoryboardIdentifier:@"ftoFullCustomSetEditor"];
    JSet *set = [[JSetStore instance] create];
    set.reps = @4;
    set.percentage = N(50);
    set.amrap = YES;
    set.warmup = NO;
    [editor setSet:set];

    [editor.reps setText:@"6"];
    [editor.percentage setText:@"80.5"];
    [editor.amrapSwitch setOn:NO];
    [editor.warmupSwitch setOn:YES];

    [editor valuesChanged:editor.amrapSwitch];

    STAssertEqualObjects(set.reps, N(6), @"");
    STAssertEqualObjects(set.percentage, N(80.5), @"");
    STAssertFalse(set.amrap, @"");
    STAssertTrue(set.warmup, @"");
}

@end