#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOTriumvirateViewController.h"
#import "FTOTriumvirate.h"
#import "Workout.h"
#import "FTOTriumvirateStore.h"
#import "Set.h"
#import "FTOTriumvirateCell.h"
#import "Lift.h"
#import "FTOTriumvirateSetupViewController.h"

@interface FTOTriumvirateViewController ()
@property(nonatomic, strong) FTOTriumvirate *triumvirateToEdit;
@property(nonatomic, strong) Set *setToEdit;
@end

@implementation FTOTriumvirateViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[FTOTriumvirateStore instance] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] atIndex:section];
    NSMutableArray *uniqueLifts = [@[] mutableCopy];
    [triumvirate.workout.orderedSets each:^(Set *set) {
        if (![uniqueLifts containsObject:set.lift]) {
            [uniqueLifts addObject:set.lift];
        }
    }];
    return [uniqueLifts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOTriumvirateCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOTriumvirateCell.class)];
    if (!cell) {
        cell = [FTOTriumvirateCell create];
    }

    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] atIndex:[indexPath section]];
    NSArray *uniqueSets = [self uniqueSetsFor:triumvirate.workout];
    Set *set = uniqueSets[(NSUInteger) [indexPath row]];
    [cell setSet:set withCount:[triumvirate countMatchingSets:set]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] atIndex:[indexPath section]];
    Set *set = [self uniqueSetsFor:triumvirate.workout][(NSUInteger) [indexPath row]];
    self.triumvirateToEdit = triumvirate;
    self.setToEdit = set;
    [self performSegueWithIdentifier:@"ftoTriumvirateSetupSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOTriumvirateSetupViewController *controller = [segue destinationViewController];
    [controller setupForm:self.triumvirateToEdit forSet:self.setToEdit];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] atIndex:section];
    return triumvirate.mainLift.name;
}

- (NSArray *)uniqueSetsFor:(Workout *)workout {
    NSMutableArray *uniques = [@[] mutableCopy];
    [workout.orderedSets each:^(Set *set) {
        if (![uniques detect:^BOOL(Set *unique) {
            return unique.lift == set.lift;
        }]) {
            [uniques addObject:set];
        }
    }];
    return uniques;
}

@end