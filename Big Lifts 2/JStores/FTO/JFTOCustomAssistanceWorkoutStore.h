#import "BLJStore.h"

@interface JFTOCustomAssistanceWorkoutStore : BLJStore
- (void)adjustToMainLifts;

- (void)copyTemplate:(NSString *)variant;

- (void)removeSetsForMissingAssistanceLifts;
@end