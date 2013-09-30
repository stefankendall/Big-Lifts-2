#import "BLStore.h"

@interface FTOWorkoutStore : BLStore
- (void)switchTemplate;

- (NSDictionary *)getDoneLiftsByWeek;

- (void)createWithWorkout:(id)week week:(int)week1 order:(int)order;
@end