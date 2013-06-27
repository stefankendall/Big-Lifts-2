#import "FTOLiftViewController.h"
#import "FTOLiftStore.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"

@implementation FTOLiftViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int week = section + 1;
    NSArray *liftsPerWeek = [[FTOWorkoutStore instance] findAllWhere:@"week" value:(id) [NSNumber numberWithInt:week]];
    return [liftsPerWeek count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[FTOWorkoutStore instance] unique:@"week"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOLiftViewCell"];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOLiftViewCell"];
    }

    int week = [indexPath section] + 1;
    NSUInteger index = (NSUInteger) [indexPath row];
    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:(id) [NSNumber numberWithInt:week]][index];
    Set *set = ftoWorkout.workout.sets[0];
    [cell.textLabel setText:set.lift.name];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *mapping = @{
            @0 : @"5/5/5",
            @1 : @"3/3/3",
            @2 : @"5/3/1",
            @3 : @"Deload"
    };
    return mapping[[NSNumber numberWithInteger:section]];
}


@end