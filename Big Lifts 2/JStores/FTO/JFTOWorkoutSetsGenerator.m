#import "FTOWorkoutSetsGenerator.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"
#import "JFTOLift.h"
#import "JFTOWorkoutSetsGenerator.h"

@implementation JFTOWorkoutSetsGenerator

- (NSArray *)setsForWeek:(int)week lift:(JFTOLift *)lift {
    return [self setsFor:lift][[NSNumber numberWithInt:week]];
}

- (NSDictionary *)setsFor:(JFTOLift *)lift {
    return [[self planForCurrentVariant] generate:lift];
}

- (NSDictionary *)setsFor:(JFTOLift *)lift withTemplate:(NSString *)variant {
    return [[self planForVariant:variant] generate:lift];
}

- (NSArray *)deloadWeeks {
    return [[self planForCurrentVariant] deloadWeeks];
}

- (id)planForCurrentVariant {
    FTOVariant *variant = [[FTOVariantStore instance] first];
    return [self planForVariant:variant.name];
}

- (NSObject <JFTOPlan> *)planForVariant:(NSString *)variant {
    NSDictionary *templatePlans = @{
            FTO_VARIANT_STANDARD : [JFTOStandardPlan new],
            FTO_VARIANT_HEAVIER : [JFTOHeavierPlan new],
            FTO_VARIANT_PYRAMID : [JFTOPyramidPlan new],
            FTO_VARIANT_JOKER : [JFTOJokerPlan new],
            FTO_VARIANT_SIX_WEEK : [JFTOSixWeekPlan new],
            FTO_VARIANT_FIRST_SET_LAST_MULTIPLE_SETS : [JFTOFirstSetLastMultipleSetsPlan new],
            FTO_VARIANT_ADVANCED : [JFTOAdvancedPlan new],
            FTO_VARIANT_FIVES_PROGRESSION : [JFTOFivesProgression new],
            FTO_VARIANT_CUSTOM : [JFTOCustomPlan new]
    };
    return templatePlans[variant];
}

- (NSArray *)incrementMaxesWeeks {
    return [[self planForCurrentVariant] incrementMaxesWeeks];
}

@end