#import "BLStore.h"

@interface FTOWorkoutStore : BLStore
- (void)switchTemplate;

- (void)createWithWorkout:(id)week week:(int)week1 order:(int)order;
@end