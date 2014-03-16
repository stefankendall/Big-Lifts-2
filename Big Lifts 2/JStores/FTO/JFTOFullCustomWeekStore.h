#import "BLJStore.h"

@class JFTOFullCustomWeek;

@interface JFTOFullCustomWeekStore : BLJStore
- (void)createWorkoutsForWeek:(JFTOFullCustomWeek *)week;

- (void)adjustToMainLifts;
@end