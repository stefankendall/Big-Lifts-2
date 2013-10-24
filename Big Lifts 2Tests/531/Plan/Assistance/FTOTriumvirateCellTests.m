#import "FTOTriumvirateCellTests.h"
#import "FTOTriumvirateCell.h"
#import "FTOTriumvirate.h"
#import "FTOTriumvirateStore.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"

@implementation FTOTriumvirateCellTests

- (void)testSetsLabels {
    FTOTriumvirateCell *cell = [FTOTriumvirateCell create];
    FTOTriumvirate *triumvirateMovement = [[FTOTriumvirateStore instance] first];

    Set *set = triumvirateMovement.workout.orderedSets[0];
    set.lift.name = @"Dumbbell Bench";
    set.reps = @12;

    [cell setSet:set withCount:7];
    STAssertEqualObjects([cell.liftLabel text], @"Dumbbell Bench", @"");
    STAssertEqualObjects([cell.setsLabel text], @"7 sets", @"");
    STAssertEqualObjects([cell.repsLabel text], @"12 reps", @"");
}

@end