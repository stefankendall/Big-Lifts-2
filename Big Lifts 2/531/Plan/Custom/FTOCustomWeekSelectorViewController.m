#import "FTOCustomWeekSelectorViewController.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkoutViewController.h"
#import "FTOCustomWorkout.h"


@interface FTOCustomWeekSelectorViewController ()
@property(nonatomic, strong) FTOCustomWorkout *tappedWorkout;
@end

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
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOCustomWeekCell"];
    }

    int week = [[self getWeeks][(NSUInteger) [indexPath row]] intValue];
    NSString *weekText = [NSString stringWithFormat:@"Week %d", week];
    [[cell textLabel] setText:weekText];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *week = [NSNumber numberWithInteger:[indexPath row] + 1];
    self.tappedWorkout = [[FTOCustomWorkoutStore instance] find:@"week" value:week];
    [self performSegueWithIdentifier:@"ftoCustomWeekSelectedSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOCustomWorkoutViewController *controller = [segue destinationViewController];
    controller.customWorkout = self.tappedWorkout;

    [super prepareForSegue:segue sender:sender];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[FTOCustomWorkoutStore instance] removeAtIndex:[indexPath row]];
        [self.tableView reloadData];
    }
}


- (IBAction)editWeekTapped:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO];
        [self.editWeekButton setTitle:@"Edit Weeks"];
    }
    else {
        [self.tableView setEditing:YES];
        [self.editWeekButton setTitle:@"Done"];
    }
}


@end