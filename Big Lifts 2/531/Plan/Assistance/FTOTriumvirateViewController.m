#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOTriumvirateViewController.h"
#import "FTOTriumvirate.h"
#import "Workout.h"
#import "FTOTriumvirateStore.h"
#import "Set.h"
#import "Set.h"
#import "FTOTriumvirateCell.h"

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
    [cell setSet:set withCount:[self countSetsInWorkout:triumvirate.workout forSet:set]];
    return cell;
}

- (int)countSetsInWorkout:(Workout *)workout forSet:(Set *)set {
    return [[[workout.sets array] select:^(Set *testSet) {
        BOOL matches = set.lift == testSet.lift;
        return matches;
    }] count];
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