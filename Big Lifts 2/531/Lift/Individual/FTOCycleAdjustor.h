@interface FTOCycleAdjustor : NSObject
- (void)checkForCycleChange;

- (void)nextCycle;

- (BOOL)midPointOfSixWeekCycle;

- (BOOL)cycleNeedsToIncrement;
@end