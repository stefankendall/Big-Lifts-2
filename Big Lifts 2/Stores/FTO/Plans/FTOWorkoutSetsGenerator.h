#import "FTOLift.h"
#import "FTOPlan.h"

@interface FTOWorkoutSetsGenerator : NSObject
- (NSArray *)setsForWeek:(int)week lift:(FTOLift *)lift;

- (NSDictionary *)setsFor:(FTOLift *)lift;

- (NSDictionary *)setsFor:(FTOLift *)lift withTemplate:(NSString *)variant;

- (NSArray *)deloadWeeks;

- (id)planForCurrentVariant;

- (NSObject <FTOPlan> *)planForVariant:(NSString *)variant;

- (NSArray *)incrementMaxesWeeks;
@end