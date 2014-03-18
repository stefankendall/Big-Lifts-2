#import "FTOFullCustomSetEditorTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOFullCustomSetEditor.h"
#import "JSetStore.h"
#import "JSet.h"

@implementation FTOFullCustomSetEditorTests

- (void)testSetsDataOnLoad {
    FTOFullCustomSetEditor *editor = [self getControllerByStoryboardIdentifier:@"ftoFullCustomSetEditor"];
    JSet *set = [[JSetStore instance] create];
    set.amrap = YES;
    set.warmup = NO;
    [editor setSet:set];
    [editor viewWillAppear:NO];
    
    STAssertTrue([[editor amrapSwitch] isOn], @"");
    STAssertFalse([[editor warmupSwitch] isOn], @"");
}

- (void)testCanChangeSetData {
    FTOFullCustomSetEditor *editor = [self getControllerByStoryboardIdentifier:@"ftoFullCustomSetEditor"];
    JSet *set = [[JSetStore instance] create];
    set.amrap = YES;
    set.warmup = NO;
    [editor setSet:set];

    [editor.amrapSwitch setOn:NO];
    [editor.warmupSwitch setOn:YES];
    [editor valuesChanged:editor.amrapSwitch];

    STAssertFalse(set.amrap, @"");
    STAssertTrue(set.warmup, @"");
}

@end