#import "SVLiftSelectorViewController.h"
#import "JSVWorkoutStore.h"

@implementation SVLiftSelectorViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *titles = @[@"Intro Microcycle", @"Base Mesocycle", @"Switching", @"Intense Mesocycle", @"Tapering"];
    return titles[(NSUInteger) section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int cycle = section + 1;
    NSArray *workoutsInCycle = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:[NSNumber numberWithInt:cycle]];
    return [workoutsInCycle count];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
//}

@end