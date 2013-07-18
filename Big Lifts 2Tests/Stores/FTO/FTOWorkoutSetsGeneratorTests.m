#import "FTOWorkoutSetsGeneratorTests.h"
#import "FTOWorkoutSetsGenerator.h"
#import "FTOLiftStore.h"
#import "Set.h"
#import "FTOVariantStore.h"

@implementation FTOWorkoutSetsGeneratorTests

- (void)testGeneratesRegularSets {
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSArray *sets = [generator setsForWeek:1 lift:squat];
    STAssertEquals([sets count], 6U, @"");
    Set *set = sets[0];
    Set *lastSet = [sets lastObject];
    STAssertEqualObjects(set.lift, squat, @"");
    STAssertTrue(lastSet.amrap, @"");
}

- (void)testGeneratesPyramidSets {
    [[[FTOVariantStore instance] first] setName: @"Pyramid"];
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSArray *sets = [generator setsForWeek:1 lift:squat];
    STAssertEquals([sets count], 8U, @"");
    STAssertTrue([[sets lastObject] amrap], @"");
    STAssertTrue([sets[5] amrap], @"");
}

- (void)testGeneratesJokerSets {
    [[[FTOVariantStore instance] first] setName: @"Joker"];
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSArray *sets = [generator setsForWeek:1 lift:squat];
    STAssertEquals([sets count], 9U, @"");
}

@end