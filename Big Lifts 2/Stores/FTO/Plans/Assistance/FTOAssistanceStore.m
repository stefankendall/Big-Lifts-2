#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"
#import "FTONoneAssistance.h"
#import "FTOBoringButBigAssistance.h"
#import "FTOTriumvirateAssistance.h"

@implementation FTOAssistanceStore

- (void)setupDefaults {
    FTOAssistance *assistance = [self create];
    assistance.name = FTO_ASSISTANCE_NONE;
}

- (void)changeTo: (NSString*) assistanceName {
    FTOAssistance *assistance = [self first];
    assistance.name = assistanceName;
    [self addAssistance];
}

- (void) addAssistance {
    NSDictionary *assistanceGenerators = @{
            FTO_ASSISTANCE_NONE : [FTONoneAssistance new],
            FTO_ASSISTANCE_BORING_BUT_BIG : [FTOBoringButBigAssistance new],
            FTO_ASSISTANCE_TRIUMVIRATE : [FTOTriumvirateAssistance new]
    };
    [assistanceGenerators[([[self first] name])] setup];
}

@end