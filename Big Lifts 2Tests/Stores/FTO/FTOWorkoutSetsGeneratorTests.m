#import "FTOWorkoutSetsGeneratorTests.h"
#import "FTOWorkoutSetsGenerator.h"
#import "FTOLiftStore.h"
#import "Set.h"
#import "JFTOVariantStore.h"
#import "FTOVariant.h"
#import "SetData.h"

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
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_PYRAMID];
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSArray *sets = [generator setsForWeek:1 lift:squat];
    STAssertEquals([sets count], 8U, @"");
    STAssertTrue([[sets lastObject] amrap], @"");
    STAssertTrue([sets[5] amrap], @"");
}

- (void)testGeneratesJokerSets {
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_JOKER];
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSArray *sets = [generator setsForWeek:1 lift:squat];
    STAssertEquals([sets count], 9U, @"");
}

- (void)testGeneratesSixWeek {
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_SIX_WEEK];
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    NSDictionary *template = [generator setsFor:[[FTOLiftStore instance] find:@"name" value:@"Squat"]];
    STAssertEquals([[template allKeys] count], 7U, @"");
}

- (void)testFirstSetLastMultipleSets {
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_FIRST_SET_LAST_MULTIPLE_SETS];
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSArray *sets = [generator setsForWeek:1 lift:squat];
    STAssertEquals([sets count], 11U, @"");
    SetData *lastSet = [sets lastObject];
    STAssertEquals([lastSet maxReps], 8, @"");
}

- (void)testCustom {
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_CUSTOM];
    FTOWorkoutSetsGenerator *generator = [FTOWorkoutSetsGenerator new];
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSArray *sets = [generator setsForWeek:1 lift:squat];
    STAssertEquals([sets count], 6U, @"");
}

@end