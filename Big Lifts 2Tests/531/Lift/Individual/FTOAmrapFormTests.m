#import "FTOAmrapFormTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOSetRepsForm.h"
#import "SetStore.h"
#import "FTOSetStore.h"
#import "FTOSet.h"
#import "FTOLiftStore.h"
#import "Lift.h"

@implementation FTOAmrapFormTests

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

@end