#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOTriumvirateViewController.h"
#import "JFTOTriumvirate.h"
#import "JWorkout.h"
#import "JSet.h"
#import "FTOTriumvirateCell.h"
#import "FTOTriumvirateSetupViewController.h"
#import "JLift.h"
#import "JFTOTriumvirateStore.h"

@interface FTOTriumvirateViewController ()
@property(nonatomic, strong) JFTOTriumvirate *triumvirateToEdit;
@property(nonatomic, strong) JSet *setToEdit;
@end

@implementation FTOTriumvirateViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[JFTOTriumvirateStore instance] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] atIndex:section];
    NSMutableArray *uniqueLifts = [@[] mutableCopy];
    [triumvirate.workout.sets each:^(JSet *set) {
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

    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] atIndex:[indexPath section]];
    NSArray *uniqueSets = [self uniqueSetsFor:triumvirate.workout];
    JSet *set = uniqueSets[(NSUInteger) [indexPath row]];
    [cell setSet:set withCount:[triumvirate countMatchingSets:set]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] atIndex:[indexPath section]];
    JSet *set = [self uniqueSetsFor:triumvirate.workout][(NSUInteger) [indexPath row]];
    self.triumvirateToEdit = triumvirate;
    self.setToEdit = set;
    [self performSegueWithIdentifier:@"ftoTriumvirateSetupSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOTriumvirateSetupViewController *controller = [segue destinationViewController];
    [controller setupForm:self.triumvirateToEdit forSet:self.setToEdit];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] atIndex:section];
    return triumvirate.mainLift.name;
}

- (NSArray *)uniqueSetsFor:(JWorkout *)workout {
    NSMutableArray *uniques = [@[] mutableCopy];
    [workout.sets each:^(JSet *set) {
        if (![uniques detect:^BOOL(JSet *unique) {
            return unique.lift == set.lift;
        }]) {
            [uniques addObject:set];
        }
    }];
    return uniques;
}

@end