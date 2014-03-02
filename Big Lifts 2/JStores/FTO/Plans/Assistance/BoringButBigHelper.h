@class JLift;
@class JWorkout;

@interface BoringButBigHelper : NSObject
+ (void)addSetsToWorkout:(JWorkout *)workout withLift:(JLift *)lift deload:(BOOL)deload;
@end