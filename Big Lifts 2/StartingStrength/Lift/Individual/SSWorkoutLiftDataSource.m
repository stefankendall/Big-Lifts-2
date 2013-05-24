#import "SSWorkoutLiftDataSource.h"
#import "SSWorkout.h"
#import "Workout.h"

@implementation SSWorkoutLiftDataSource
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
    Workout *workout = [[ssWorkout workouts] objectAtIndex:(NSUInteger) workoutIndex];
    return [[workout sets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell  *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"SSIndividualWorkoutCell"];

    if (cell == nil) {
        cell = [UITableViewCell new];
    }

    return cell;
}

@end