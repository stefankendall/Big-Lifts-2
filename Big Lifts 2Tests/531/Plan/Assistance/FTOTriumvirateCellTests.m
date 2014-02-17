#import "FTOTriumvirateCellTests.h"
#import "FTOTriumvirateCell.h"
#import "JFTOTriumvirateStore.h"
#import "JSet.h"
#import "JFTOTriumvirate.h"
#import "JWorkout.h"
#import "JLift.h"

@implementation FTOTriumvirateCellTests

- (void)testSetsLabels {
    FTOTriumvirateCell *cell = [FTOTriumvirateCell create];
    JFTOTriumvirate *triumvirateMovement = [[JFTOTriumvirateStore instance] first];

    JSet *set = triumvirateMovement.workout.sets[0];
    set.lift.name = @"Dumbbell Bench";
    set.reps = @12;

    [cell setSet:set withCount:7];
    STAssertEqualObjects([cell.liftLabel text], @"Dumbbell Bench", @"");
    STAssertEqualObjects([cell.setsLabel text], @"7 sets", @"");
    STAssertEqualObjects([cell.repsLabel text], @"12 reps", @"");
}

@end