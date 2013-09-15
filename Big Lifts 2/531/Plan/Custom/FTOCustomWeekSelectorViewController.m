#import "FTOCustomWeekSelectorViewController.h"
#import "FTOCustomWorkoutStore.h"

@implementation FTOCustomWeekSelectorViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getWeeks] count];
}

- (NSArray *)getWeeks {
    return [[[FTOCustomWorkoutStore instance] unique:@"week"] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOCustomWeekCell"];
    if( !cell ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOCustomWeekCell"];
    }

    NSLog(@"%@", [self getWeeks]);

    int week = [[self getWeeks][(NSUInteger) [indexPath row]] intValue];
    NSString *weekText = [NSString stringWithFormat:@"Week %d", week];
    [[cell textLabel] setText:weekText];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end