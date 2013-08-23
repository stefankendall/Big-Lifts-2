#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"
#import "FTONoneAssistance.h"
#import "FTOBoringButBigAssistance.h"
#import "FTOTriumvirateAssistance.h"
#import "FTOSimplestStrengthTemplateAssistance.h"

@implementation FTOAssistanceStore

- (void)setupDefaults {
    FTOAssistance *assistance = [self create];
    assistance.name = FTO_ASSISTANCE_NONE;
}

- (void)changeTo:(NSString *)assistanceName {
    FTOAssistance *assistance = [self first];
    assistance.name = assistanceName;
    [self addAssistance];
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