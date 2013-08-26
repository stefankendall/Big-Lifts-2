#import "Workout.h"
#import "FTOBoringButBigViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOBoringButBigViewController.h"
#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "SetData.h"

@implementation FTOBoringButBigViewControllerTests

-(void) testChangingPercentageUpdatesBbbLifts {
    [[FTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOBoringButBigViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoBoring"];
    UITextField *field = [UITextField new];
    field.text = @"60";
    [controller percentageChanged:field];

    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] first];
    STAssertEquals([ftoWorkout.workout.sets count], 11U, @"");
    STAssertEqualObjects([[ftoWorkout.workout.sets lastObject] percentage], N(60), @"");
}

@end