@interface FTOCycleAdjustor : NSObject
- (void)checkForCycleChange;

- (BOOL)shouldIncrementLifts;

- (void)nextCycle;

- (BOOL)reachedEndOfIncrementWeek;

- (BOOL)cycleNeedsToIncrement;
@end