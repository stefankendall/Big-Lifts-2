#import "JFTOTriumvirateAssistanceCopy.h"
#import "JFTOTriumvirateLiftStore.h"
#import "NSArray+Enumerable.h"
#import "JFTOTriumvirateLift.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JLiftStore.h"

@implementation JFTOTriumvirateAssistanceCopy

- (void)copyTemplate {
    [self copyLifts];
    [self copyWorkouts];
}

- (void)copyLifts {
    [[[JFTOTriumvirateLiftStore instance] findAll] each:^(JFTOTriumvirateLift *triumvirateLift) {
        JFTOCustomAssistanceLift *customLift = [[JFTOCustomAssistanceLiftStore instance] create];
        [[JLiftStore instance] copy:triumvirateLift into:customLift];
    }];
}

@end