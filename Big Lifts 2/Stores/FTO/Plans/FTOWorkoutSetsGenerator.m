#import "FTOWorkoutSetsGenerator.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"
#import "FTOPlan.h"
#import "FTOStandardPlan.h"
#import "FTOPyramidPlan.h"
#import "FTOJokerPlan.h"
#import "FTOSixWeekPlan.h"
#import "FTOFirstSetLastMultipleSetsPlan.h"
#import "FTOAdvancedPlan.h"
#import "FTOFivesProgression.h"
#import "FTOCustomPlan.h"

@implementation FTOWorkoutSetsGenerator

- (NSArray *)setsForWeek:(int)week lift:(FTOLift *)lift {
    return [self setsFor:lift][[NSNumber numberWithInt:week]];
}

- (NSDictionary *)setsFor:(FTOLift *)lift {
    return [[self planForCurrentVariant] generate:lift];
}

- (NSDictionary *)setsFor:(FTOLift *)lift withTemplate:(NSString *)variant {
    return [[self planForVariant:variant] generate:lift];
}

- (NSArray *)deloadWeeks {
    return [[self planForCurrentVariant] deloadWeeks];
}

- (id)planForCurrentVariant {
    FTOVariant *variant = [[FTOVariantStore instance] first];
    return [self planForVariant:variant.name];
}

- (NSObject <FTOPlan> *)planForVariant:(NSString *)variant {
    NSDictionary *templatePlans = @{
            FTO_VARIANT_STANDARD : [FTOStandardPlan new],
            FTO_VARIANT_PYRAMID : [FTOPyramidPlan new],
            FTO_VARIANT_JOKER : [FTOJokerPlan new],
            FTO_VARIANT_SIX_WEEK : [FTOSixWeekPlan new],
            FTO_VARIANT_FIRST_SET_LAST_MULTIPLE_SETS : [FTOFirstSetLastMultipleSetsPlan new],
            FTO_VARIANT_ADVANCED : [FTOAdvancedPlan new],
            FTO_VARIANT_FIVES_PROGRESSION : [FTOFivesProgression new],
            FTO_VARIANT_CUSTOM : [FTOCustomPlan new]
    };
    return templatePlans[variant];
}

@end