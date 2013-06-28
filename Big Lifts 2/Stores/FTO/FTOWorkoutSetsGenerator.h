#import "FTOLift.h"

@interface FTOWorkoutSetsGenerator : NSObject
- (NSArray *)setsForWeek:(int)week lift:(FTOLift *)lift;
@end