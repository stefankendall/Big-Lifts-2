#import "FTOWorkoutSetsGenerator.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"
#import "FTOPlan.h"
#import "FTOStandardPlan.h"
#import "FTOPyramidPlan.h"
#import "FTOJokerPlan.h"
#import "FTOSixWeekPlan.h"
#import "FTOFirstSetLastMultipleSetsPlan.h"

@implementation FTOWorkoutSetsGenerator

- (NSArray *)setsForWeek:(int)week lift:(FTOLift *)lift {
    return [self setsFor:lift][[NSNumber numberWithInt:week]];
}

- (NSDictionary *)setsFor:(FTOLift *)lift {
    FTOVariant *variant = [[FTOVariantStore instance] first];
    NSDictionary *templatePlans = @{
            FTO_VARIANT_STANDARD: [FTOStandardPlan new],
            FTO_VARIANT_PYRAMID: [FTOPyramidPlan new],
            FTO_VARIANT_JOKER: [FTOJokerPlan new],
            FTO_VARIANT_SIX_WEEK: [FTOSixWeekPlan new],
            FTO_VARIANT_FIRST_SET_LAST_MULTIPLE_SETS: [FTOFirstSetLastMultipleSetsPlan new]
    };
    return [templatePlans[variant.name] generate: lift];
}

@end