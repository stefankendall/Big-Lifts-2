@interface FTOCycleAdjustor : NSObject
- (void)checkForCycleChange;

- (BOOL)cycleNeedsToIncrement;
@end