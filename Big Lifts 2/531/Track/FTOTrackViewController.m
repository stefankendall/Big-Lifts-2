#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"

@implementation FTOTrackViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getLog] count];
}

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
}

@end