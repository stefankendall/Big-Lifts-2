#import "FTOCustomAssistanceEditSetViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomAssistanceEditSetViewController.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"

@implementation FTOCustomAssistanceEditSetViewControllerTests

-(void) testShowsHidesAddButton {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    STAssertFalse([controller.addLiftButton isHidden], @"");

    [[JFTOCustomAssistanceLiftStore instance] create];

    [controller viewWillAppear:NO];
    STAssertTrue([controller.addLiftButton isHidden], @"");
}

@end