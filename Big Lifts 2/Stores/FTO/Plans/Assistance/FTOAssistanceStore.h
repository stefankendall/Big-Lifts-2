#import "BLStore.h"

@interface FTOAssistanceStore : BLStore

- (void)changeTo: (NSString*) assistanceName;

- (void)cycleChange;
@end