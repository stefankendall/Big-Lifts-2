@interface FTOCycleAdjustor : NSObject
- (void)checkForCycleChange;

- (BOOL)midPointOfSixWeekCycle;

- (BOOL)cycleNeedsToIncrement;
@end