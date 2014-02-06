#import "JWorkout.h"
#import "FTOBoringButBigViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOBoringButBigViewController.h"
#import "JFTOAssistanceStore.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "FTOCycleAdjustor.h"
#import "JFTOAssistance.h"
#import "JSet.h"

@implementation FTOBoringButBigViewControllerTests

- (void)testChangingPercentage {
    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOBoringButBigViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoBoring"];
    UITextField *field = [UITextField new];
    field.text = @"60";
    [controller percentageChanged:field];
    [[JFTOAssistanceStore instance] restore];

    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals([ftoWorkout.workout.orderedSets count], (NSUInteger) 11, @"");
    JSet *set = [ftoWorkout.workout.orderedSets lastObject];
    STAssertEqualObjects([set percentage], N(60), @"");
}

- (void)testThreeMonthChallengeUntoggled {
    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    [[FTOCycleAdjustor new] nextCycle];

    JFTOWorkout *ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    STAssertEqualObjects([ftoWorkout.workout.orderedSets.lastObject percentage], N(50), @"");
}

- (void)testThreeMonthChallengeToggled {
    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOBoringButBigViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoBoring"];
    UISwitch *toggle = [UISwitch new];
    [toggle setOn:YES];
    [controller toggleThreeMonthChallenge:toggle];
    [[FTOCycleAdjustor new] nextCycle];

    JFTOWorkout *ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    STAssertEqualObjects([ftoWorkout.workout.orderedSets.lastObject percentage], N(60), @"");
}

@end