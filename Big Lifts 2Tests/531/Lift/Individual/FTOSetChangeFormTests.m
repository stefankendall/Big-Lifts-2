#import "FTOSetChangeFormTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOSetChangeForm.h"
#import "JFTOSetStore.h"
#import "JFTOLiftStore.h"
#import "JFTOSet.h"
#import "JLift.h"
#import "IAPAdapter.h"
#import "Purchaser.h"

@implementation FTOSetChangeFormTests

- (void)testSetSetSetsFormFields {
    FTOSetChangeForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    JFTOSet *set = [[JFTOSetStore instance] create];
    set.percentage = N(100);
    set.lift = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    set.lift.weight = N(200);
    set.reps = @3;
    [controller setSet:set];
    [controller setupFields];

    STAssertEqualObjects([[controller weightField] placeholder], @"180", @"");
    STAssertEqualObjects([[controller repsField] placeholder], @"3", @"");
}

- (void)testSetsOneRepMaxWhenViewAppears {
    [[IAPAdapter instance] addPurchase:IAP_1RM];
    FTOSetChangeForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    JFTOSet *set = [[JFTOSetStore instance] create];
    set.percentage = N(100);
    set.lift = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    set.lift.weight = N(200);
    set.reps = @3;
    [controller setSet:set];
    [controller viewWillAppear:YES];

    STAssertEqualObjects([[controller oneRepField] text], @"198", @"");
}

- (void)testUsesPreviousEnteredRepsForOneRepMax {
    [[IAPAdapter instance] addPurchase:IAP_1RM];
    FTOSetChangeForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    JFTOSet *set = [[JFTOSetStore instance] create];
    set.percentage = N(100);
    set.lift = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    set.lift.weight = N(200);
    set.reps = @3;
    [controller setSet:set];
    [controller setPreviouslyEnteredReps:5];
    [controller viewWillAppear:YES];

    STAssertEqualObjects([[controller oneRepField] text], @"210", @"");
}

- (void)testUsesPreviouslyEnteredWeightForOneRepMax {
    [[IAPAdapter instance] addPurchase:IAP_1RM];
    FTOSetChangeForm *controller = [self getControllerByStoryboardIdentifier:@"ftoSetReps"];
    JFTOSet *set = [[JFTOSetStore instance] create];
    set.percentage = N(100);
    set.lift = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    set.lift.weight = N(300);
    set.reps = @1;
    [controller setSet:set];
    [controller setPreviouslyEnteredWeight:set.lift.weight];
    [controller viewWillAppear:YES];
    STAssertEqualObjects([[controller oneRepField] text], @"300", @"");
}

@end