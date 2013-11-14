#import "BLStore.h"

@interface FTOCustomWorkoutStore : BLStore
- (void)removeDuplicates;

- (void)reorderWeeks;

- (void)setupVariant:(NSString *)variant;
@end