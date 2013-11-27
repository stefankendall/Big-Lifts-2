#import "JFTOLift.h"

@protocol JFTOPlan;

@interface JFTOWorkoutSetsGenerator : NSObject
- (NSArray *)setsForWeek:(int)week lift:(JFTOLift *)lift;

- (NSDictionary *)setsFor:(JFTOLift *)lift;

- (NSDictionary *)setsFor:(JFTOLift *)lift withTemplate:(NSString *)variant;

- (NSArray *)deloadWeeks;

- (id)planForCurrentVariant;

- (NSObject <JFTOPlan> *)planForVariant:(NSString *)variant;

- (NSArray *)incrementMaxesWeeks;
@end