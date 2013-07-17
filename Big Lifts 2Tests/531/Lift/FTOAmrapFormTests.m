#import "FTOAmrapFormTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOAmrapForm.h"
#import "SetStore.h"
#import "FTOSetStore.h"
#import "FTOSet.h"
#import "FTOLiftStore.h"
#import "Lift.h"

@implementation FTOAmrapFormTests

- (void)testSetSetSetsFormFields {
    FTOAmrapForm *controller = [self getControllerByStoryboardIdentifier:@"ftoAmrap"];
    FTOSet *set = [[FTOSetStore instance] create];
    set.percentage = N(100);
    set.lift = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    set.lift.weight = N(200);
    set.reps = @3;
    [controller setSet:set];

    STAssertEqualObjects([[controller weightField] text], @"180 lbs", @"");
    STAssertEqualObjects([[controller repsField] placeholder], @"3", @"");
}

@end