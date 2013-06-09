#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "SetCell.h"
#import "SetCellWithPlates.h"

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
    Workout *workout = [[self.ssWorkout workouts] objectAtIndex:(NSUInteger) self.workoutIndex];
    return workout;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetCellWithPlates *cell = (SetCellWithPlates *) [tableView dequeueReusableCellWithIdentifier:@"SetCellWithPlates"];

    if (cell == nil) {
        cell = [SetCellWithPlates create];
    }

    [cell setSet:[[[self getCurrentWorkout] sets] objectAtIndex:(NSUInteger) [indexPath row]]];
    return cell;
}

@end