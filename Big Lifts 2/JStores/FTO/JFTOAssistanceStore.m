#import "JFTOAssistanceStore.h"
#import "JFTOAssistance.h"
#import "JFTOWorkout.h"
#import "JSet.h"
#import "JWorkout.h"
#import "JFTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "JFTOAssistanceProtocol.h"
#import "JFTOTriumvirateAssistance.h"
#import "JFTOBoringButBigAssistance.h"
#import "JFTONoneAssistance.h"
#import "JFTOSimplestStrengthTemplateAssistance.h"
#import "JFTOCustomAssistance.h"
#import "JFTOFullCustomAssistance.h"

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
        NSArray *assistanceSets = [ftoWorkout.workout.sets select:^BOOL(JSet *set) {
            return set.assistance;
        }];
        [ftoWorkout.workout removeSets:assistanceSets];
    }];
}

- (void)addAssistance {
    NSObject <JFTOAssistanceProtocol> *generator = [self assistanceGeneratorForName:[[self first] name]];
    [generator setup];
}

- (void)cycleChange {
    [[self assistanceGeneratorForName:[[self first] name]] cycleChange];
}

- (NSObject <JFTOAssistanceProtocol> *)assistanceGeneratorForName:(NSString *)name {
    NSDictionary *assistanceGenerators = @{
            FTO_ASSISTANCE_NONE : [JFTONoneAssistance new],
            FTO_ASSISTANCE_BORING_BUT_BIG : [JFTOBoringButBigAssistance new],
            FTO_ASSISTANCE_TRIUMVIRATE : [JFTOTriumvirateAssistance new],
            FTO_ASSISTANCE_SST : [JFTOSimplestStrengthTemplateAssistance new],
            FTO_ASSISTANCE_CUSTOM : [JFTOCustomAssistance new],
            FTO_ASSISTANCE_FULL_CUSTOM : [JFTOFullCustomAssistance new]
    };
    return assistanceGenerators[name];
}

@end