@interface CrashCounter : NSObject
+ (void)incrementCrashCounter;

+ (int)crashCount;

+ (void)resetCrashCounter;
@end