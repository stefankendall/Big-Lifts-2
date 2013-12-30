#import "FTOLiftViewController.h"
#import "FTOLiftWorkoutViewController.h"
#import "JFTOLiftStore.h"
#import "JFTOWorkoutStore.h"
#import "JWorkout.h"
#import "RateDialog.h"
#import "JSet.h"
#import "JLift.h"
#import "JFTOVariant.h"
#import "JFTOVariantStore.h"
#import "JFTOCustomWorkoutStore.h"
#import "JFTOWorkout.h"

@interface FTOLiftViewController ()

@property(nonatomic) JFTOWorkout *nextWorkout;
@end

@implementation FTOLiftViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    self.rateDialog = [RateDialog new];
    [self.rateDialog show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int week = section + 1;
    NSArray *liftsPerWeek = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:(id) [NSNumber numberWithInt:week]];
    return [liftsPerWeek count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[JFTOWorkoutStore instance] unique:@"week"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOLiftViewCell"];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOLiftViewCell"];
    }

    int week = [indexPath section] + 1;
    NSUInteger index = (NSUInteger) [indexPath row];
    JFTOWorkout *ftoWorkout = [self getWorkout:week row:index];

    if ([ftoWorkout.workout.orderedSets count] > 0) {
        JSet *set = ftoWorkout.workout.orderedSets[0];
        [cell.textLabel setText:set.lift.name];
    }
    else {
        [cell.textLabel setText:@"Empty workout"];
    }


    if (ftoWorkout.done) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

    return cell;
}

- (JFTOWorkout *)getWorkout:(int)week row:(NSUInteger)index {
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:(id) [NSNumber numberWithInt:week]][index];
    return ftoWorkout;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    JFTOVariant *variant = [[JFTOVariantStore instance] first];
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
    else if ([variant.name isEqualToString:FTO_VARIANT_ADVANCED]) {
        mapping = @{
                @0 : @"Week 1",
                @1 : @"Week 2",
                @2 : @"Week 3",
                @3 : @"Deload (opt.)",
        };
    }
    else if ([variant.name isEqualToString:FTO_VARIANT_CUSTOM]) {
        return [[[JFTOCustomWorkoutStore instance] find:@"week" value:[NSNumber numberWithInteger:section + 1]] name];
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