#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "SetCell.h"
#import "SetCellWithPlates.h"
#import "IAPAdapter.h"
#import "Purchaser.h"

@implementation SSIndividualWorkoutDataSource

- (id)initWithSsWorkout:(SSWorkout *)ssWorkout1 {
    self = [super init];
    if (self) {
        self.ssWorkout = ssWorkout1;
        self.workoutIndex = 0;
    }

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self getCurrentWorkout] sets] count];
}

- (Workout *)getCurrentWorkout {
    return [[self.ssWorkout workouts] objectAtIndex:(NSUInteger) self.workoutIndex];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class setClass = [[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING] ? SetCellWithPlates.class : SetCell.class;
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(setClass)];

    if (cell == nil) {
        cell = [setClass create];
    }

    Workout *workout = [self getCurrentWorkout];
    [cell setSet:[[workout sets] objectAtIndex:(NSUInteger) [indexPath row]]];
    return cell;
}

@end