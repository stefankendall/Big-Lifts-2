#import "SSNavTableViewController.h"

@implementation SSNavTableViewController

- (NSDictionary *)specificTagMapping {
    return @{
            @1 : @"ssEditViewController",
            @0 : @"ssLiftViewController",
            @3 : @"ssTrackViewController",
            @7 : @"ssPlanWorkoutsNav"
    };
}

@end