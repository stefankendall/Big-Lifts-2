#import "BLJStore.h"

@class JFTOFullCustomWeek;
@class JFTOFullCustomWorkout;

@interface JFTOFullCustomWeekStore : BLJStore
- (void)createWorkoutsForWeek:(JFTOFullCustomWeek *)week;

- (void)adjustToMainLifts;

- (JFTOFullCustomWeek *)weekContaining:(JFTOFullCustomWorkout *)workout;

@end