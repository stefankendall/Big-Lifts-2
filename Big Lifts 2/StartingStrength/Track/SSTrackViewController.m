#import "SSTrackViewController.h"
#import "WorkoutLogStore.h"

@implementation SSTrackViewController

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"Starting Strength"];
}

@end