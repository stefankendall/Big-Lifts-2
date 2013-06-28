#import "FTOWorkoutSetsGeneratorTests.h"
#import "FTOWorkoutSetsGenerator.h"
#import "FTOLiftStore.h"
#import "Set.h"

@implementation FTOWorkoutSetsGeneratorTests

- (void)testGeneratesRegularSets {
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSArray *sets = [generator setsForWeek:1 lift:squat];
    STAssertEquals([sets count], 6U, @"");
    Set *set = sets[0];
    STAssertEqualObjects(set.lift, squat, @"");
}

@end