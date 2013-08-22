#import "FTOSimplestStrengthTemplateAssistanceTests.h"
#import "FTOAssistanceProtocol.h"
#import "FTOSimplestStrengthTemplateAssistance.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"

@implementation FTOSimplestStrengthTemplateAssistanceTests

- (void)testSetsUpWeekPercentages {
    [[FTOSimplestStrengthTemplateAssistance new] setup];
    FTOWorkout *week1Workout = [self findWorkout:1 withLift:@"Squat"];
    STAssertEquals([[week1Workout.workout sets] count], 9U, @"");
    Set *lastSet = [week1Workout.workout sets][8];
    STAssertEquals([lastSet.reps intValue], 10, @"");
    STAssertEqualObjects(lastSet.percentage, N(70), @"");
}

- (FTOWorkout *)findWorkout:(int)week withLift:(NSString *)liftName {
    return [[[FTOWorkoutStore instance] findAll] detect:^BOOL(FTOWorkout *workout) {
        return [workout.week intValue] == week && [[workout.workout.sets[0] lift].name isEqualToString:liftName];
    }];
}

@end