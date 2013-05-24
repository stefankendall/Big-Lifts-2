#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "SetCell.h"

@implementation SSIndividualWorkoutDataSource
@synthesize ssWorkout, workoutIndex;

- (id)initWithSsWorkout:(SSWorkout *)ssWorkout1 {
    self = [super init];
    if (self) {
        ssWorkout = ssWorkout1;
        workoutIndex = 0;
    }

    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self getCurrentWorkout] sets] count];
}

- (Workout *)getCurrentWorkout {
    Workout *workout = [[ssWorkout workouts] objectAtIndex:(NSUInteger) workoutIndex];
    return workout;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetCell *cell = (SetCell *) [tableView dequeueReusableCellWithIdentifier:@"SetCell"];

    if (cell == nil) {
        cell = [SetCell createNewTextCellFromNib];
    }

    [cell setSet:[[[self getCurrentWorkout] sets] objectAtIndex:(NSUInteger) [indexPath row]]];

    return cell;
}

@end