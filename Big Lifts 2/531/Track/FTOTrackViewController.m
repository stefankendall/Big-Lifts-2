#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"

@implementation FTOTrackViewController

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
}

@end