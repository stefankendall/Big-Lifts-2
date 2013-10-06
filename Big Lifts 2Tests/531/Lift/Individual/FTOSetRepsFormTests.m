#import "FTOSetRepsFormTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOSetRepsForm.h"
#import "SetStore.h"
#import "FTOSetStore.h"
#import "FTOSet.h"
#import "FTOLiftStore.h"
#import "Lift.h"
#import "IAPAdapter.h"
#import "Purchaser.h"

@implementation FTOSetRepsFormTests

- (void)testSetSetSetsFormFields {
    FTOSetRepsForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    FTOSet *set = [[FTOSetStore instance] create];
    set.percentage = N(100);
    set.lift = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    set.lift.weight = N(200);
    set.reps = @3;
    [controller setSet:set];
    [controller setupFields];

    STAssertEqualObjects([[controller weightField] text], @"180 lbs", @"");
    STAssertEqualObjects([[controller repsField] placeholder], @"3", @"");
}

- (void)testHidesOneRepEstimateWithoutIAP {
    FTOSetRepsForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    [controller viewWillAppear:YES];
    STAssertTrue( [controller.oneRepField isHidden], @"");
}

- (void)testShowsOneRepEstimateWithIAP {
    [[IAPAdapter instance] addPurchase:IAP_1RM];
    FTOSetRepsForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    [controller viewWillAppear:YES];
    STAssertFalse( [controller.oneRepField isHidden], @"");
}

- (void)testSetsOneRepMaxWhenViewAppears {
    FTOSetRepsForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    FTOSet *set = [[FTOSetStore instance] create];
    set.percentage = N(100);
    set.lift = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    set.lift.weight = N(200);
    set.reps = @3;
    [controller setSet:set];
    [controller viewWillAppear:YES];

    STAssertEqualObjects([[controller oneRepField] text], @"198", @"");
}

- (void)testUsesPreviousEnteredRepsForOneRepMax {
    FTOSetRepsForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    FTOSet *set = [[FTOSetStore instance] create];
    set.percentage = N(100);
    set.lift = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    set.lift.weight = N(200);
    set.reps = @3;
    [controller setSet:set];
    [controller setPreviouslyEnteredReps:5];
    [controller viewWillAppear:YES];

    STAssertEqualObjects([[controller oneRepField] text], @"210", @"");
}

@end