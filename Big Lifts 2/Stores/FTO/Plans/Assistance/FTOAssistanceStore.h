#import "BLStore.h"

@interface FTOAssistanceStore : BLStore

- (void)changeTo: (NSString*) assistanceName;

- (void)restore;

- (void)addAssistance;

- (void)cycleChange;
@end