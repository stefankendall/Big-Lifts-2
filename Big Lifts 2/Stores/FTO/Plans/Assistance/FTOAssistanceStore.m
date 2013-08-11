#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"

@implementation FTOAssistanceStore

- (void)setupDefaults {
    FTOAssistance *assistance = [self create];
    assistance.name = FTO_ASSISTANCE_NONE;
}

@end