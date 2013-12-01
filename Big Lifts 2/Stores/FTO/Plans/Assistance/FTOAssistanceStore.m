#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"
#import "FTONoneAssistance.h"
#import "FTOBoringButBigAssistance.h"
#import "FTOTriumvirateAssistance.h"
#import "FTOSimplestStrengthTemplateAssistance.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "JFTOAssistance.h"

@implementation FTOAssistanceStore

- (void)setupDefaults {
    FTOAssistance *assistance = [self create];
    assistance.name = FTO_ASSISTANCE_NONE;
}

- (void)changeTo:(NSString *)assistanceName {
    [[self first] setName:assistanceName];
    [self removeAssistance];
    [[FTOWorkoutStore instance] restoreTemplate];
    [self addAssistance];
}

- (void)restore {
    [self changeTo:[[[FTOAssistanceStore instance] first] name]];
}

- (void)removeAssistance {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        NSArray *assistanceSets = [ftoWorkout.workout.orderedSets select:^BOOL(Set *set) {
            return set.assistance;
        }];
        [ftoWorkout.workout removeSets:assistanceSets];
    }];
}

- (void)addAssistance {
    NSObject <FTOAssistanceProtocol> *generator = [self assistanceGeneratorForName:[[self first] name]];
    [generator setup];
}

- (void)cycleChange {
    [[self assistanceGeneratorForName:[[self first] name]] cycleChange];
}

- (NSObject <FTOAssistanceProtocol> *)assistanceGeneratorForName:(NSString *)name {
    NSDictionary *assistanceGenerators = @{
            FTO_ASSISTANCE_NONE : [FTONoneAssistance new],
            FTO_ASSISTANCE_BORING_BUT_BIG : [FTOBoringButBigAssistance new],
            FTO_ASSISTANCE_TRIUMVIRATE : [FTOTriumvirateAssistance new],
            FTO_ASSISTANCE_SST : [FTOSimplestStrengthTemplateAssistance new]
    };
    return assistanceGenerators[name];
}

@end