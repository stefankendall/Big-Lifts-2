#import "SJTrackViewController.h"
#import "WorkoutLogStore.h"

@implementation SJTrackViewController

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov Jr"];
}

@end