#import "FTOLiftViewController.h"
#import "FTOLiftWorkoutViewController.h"
#import "FTOLiftStore.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"

@interface FTOLiftViewController ()

@property(nonatomic) FTOWorkout *nextWorkout;
@end

@implementation FTOLiftViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

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
    FTOWorkout *ftoWorkout = [self getWorkout:week row:index];
    Set *set = ftoWorkout.workout.sets[0];
    [cell.textLabel setText:set.lift.name];

    if (ftoWorkout.done) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

    return cell;
}

- (FTOWorkout *)getWorkout:(int)week row:(NSUInteger)index {
    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:(id) [NSNumber numberWithInt:week]][index];
    return ftoWorkout;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FTOVariant *variant = [[FTOVariantStore instance] first];
    NSDictionary *mapping = @{
            @0 : @"5/5/5",
            @1 : @"3/3/3",
            @2 : @"5/3/1",
            @3 : @"Deload"
    };
    if ([variant.name isEqualToString:FTO_VARIANT_SIX_WEEK]) {
        mapping = @{
                @0 : @"5/5/5",
                @1 : @"3/3/3",
                @2 : @"5/3/1",
                @3 : @"5/5/5",
                @4 : @"3/3/3",
                @5 : @"5/3/1",
                @6 : @"Deload"
        };
    }
    return mapping[[NSNumber numberWithInteger:section]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.nextWorkout = [self getWorkout:([indexPath section] + 1) row:(NSUInteger) [indexPath row]];
    [self performSegueWithIdentifier:@"ftoViewWorkout" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoViewWorkout"]) {
        FTOLiftWorkoutViewController *controller = [segue destinationViewController];
        [controller setWorkout:self.nextWorkout];
    }
}

@end