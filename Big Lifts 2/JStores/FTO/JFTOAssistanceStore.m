#import "JFTOAssistanceStore.h"
#import "JFTOAssistance.h"
#import "FTOAssistance.h"
#import "JFTOWorkout.h"
#import "JSet.h"
#import "JWorkout.h"
#import "FTOAssistanceProtocol.h"
#import "FTONoneAssistance.h"
#import "FTOBoringButBigAssistance.h"
#import "FTOTriumvirateAssistance.h"
#import "FTOSimplestStrengthTemplateAssistance.h"
#import "JFTOWorkoutStore.h"
#import "NSArray+Enumerable.h"

@implementation JFTOAssistanceStore

- (Class)modelClass {
    return JFTOAssistance.class;
}

- (void)setupDefaults {
    JFTOAssistance *assistance = [self create];
    assistance.name = FTO_ASSISTANCE_NONE;
}

- (void)changeTo:(NSString *)assistanceName {
    [[self first] setName:assistanceName];
    [self removeAssistance];
    [[JFTOWorkoutStore instance] restoreTemplate];
    [self addAssistance];
}

- (void)restore {
    [self changeTo:[[self first] name]];
}

- (void)removeAssistance {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *ftoWorkout) {
        NSArray *assistanceSets = [ftoWorkout.workout.orderedSets select:^BOOL(JSet *set) {
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