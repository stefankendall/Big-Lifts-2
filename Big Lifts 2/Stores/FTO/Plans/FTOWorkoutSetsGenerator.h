#import "FTOLift.h"

@interface FTOWorkoutSetsGenerator : NSObject
- (NSArray *)setsForWeek:(int)week lift:(FTOLift *)lift;

- (NSDictionary *)setsFor:(FTOLift *)lift;

- (NSDictionary *)setsFor:(FTOLift *)lift withTemplate:(NSString *)variant;

- (NSArray *)deloadWeeks;
@end