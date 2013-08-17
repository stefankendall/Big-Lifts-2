#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOTriumvirateViewController.h"
#import "FTOTriumvirate.h"
#import "Workout.h"
#import "FTOTriumvirateStore.h"
#import "Set.h"
#import "Set.h"
#import "FTOTriumvirateCell.h"
#import "Lift.h"

@implementation FTOTriumvirateViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[FTOTriumvirateStore instance] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] atIndex:section];
    NSMutableArray *uniqueLifts = [@[] mutableCopy];
    [[triumvirate.workout.sets array] each:^(Set *set) {
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] atIndex: section];
    return triumvirate.mainLift.name;
}

- (NSArray *)uniqueSetsFor:(Workout *)workout {
    NSMutableArray *uniques = [@[] mutableCopy];
    [[workout.sets array] each:^(Set *set) {
        if (![uniques detect:^BOOL(Set *unique) {
            return unique.lift == set.lift;
        }]) {
            [uniques addObject:set];
        }
    }];
    return uniques;
}

@end