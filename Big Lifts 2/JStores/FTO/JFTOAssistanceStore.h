#import "BLJStore.h"

@interface JFTOAssistanceStore : BLJStore
- (void)changeTo:(NSString *)assistanceName;

- (void)restore;

- (void)addAssistance;

- (void)cycleChange;
@end