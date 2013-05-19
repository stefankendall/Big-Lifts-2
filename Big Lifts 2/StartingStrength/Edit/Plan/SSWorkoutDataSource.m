#import "SSWorkoutDataSource.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "SSLift.h"
#import "Workout.h"
#import "Set.h"

@implementation SSWorkoutDataSource
@synthesize name;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self getWorkout] workouts] count];
}

- (id)initWithName:(NSString *)name1 {
    self = [super init];
    if (self) {
        name = name1;
    }

    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSWorkoutCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SSWorkoutCell"];
        [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    }

    SSWorkout *workout = [self getWorkout];
    Workout *firstWorkout = workout.workouts[0];
    Set * firstSet = firstWorkout.sets[0];
    SSLift *lift = (SSLift *) firstSet.lift;

    [[cell textLabel] setText:lift.name];
    [cell setBackgroundColor:[UIColor whiteColor]];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Workout %@", name];
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([sourceIndexPath row] == [destinationIndexPath row]) {
        return;
    }

    SSWorkout *workout = [self getWorkout];
    [workout.workouts exchangeObjectAtIndex:(NSUInteger) [sourceIndexPath row] withObjectAtIndex:(NSUInteger) [destinationIndexPath row]];
}

- (SSWorkout *)getWorkout {
    return [[SSWorkoutStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", name]];
}

@end