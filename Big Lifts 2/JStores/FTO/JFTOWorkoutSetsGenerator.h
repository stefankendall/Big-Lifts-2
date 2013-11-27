#import "JFTOLift.h"
#import "FTOPlan.h"

@class JFTOLift;

@interface JFTOWorkoutSetsGenerator : NSObject
- (NSArray *)setsForWeek:(int)week lift:(JFTOLift *)lift;

- (NSDictionary *)setsFor:(JFTOLift *)lift;

- (NSDictionary *)setsFor:(JFTOLift *)lift withTemplate:(NSString *)variant;

- (NSArray *)deloadWeeks;

- (id)planForCurrentVariant;

- (NSObject <FTOPlan> *)planForVariant:(NSString *)variant;

- (NSArray *)incrementMaxesWeeks;
@end