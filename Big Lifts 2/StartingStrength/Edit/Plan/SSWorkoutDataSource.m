#import "SSWorkoutDataSource.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "SSLift.h"

@implementation SSWorkoutDataSource
@synthesize name;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SSWorkoutStore *store = [SSWorkoutStore instance];
    SSWorkout *workout = [store findBy:[NSPredicate predicateWithFormat:@"name == %@", name]];
    return [[workout lifts] count];
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

    SSWorkout *workout = [[SSWorkoutStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", name]];
    SSLift *lift = workout.lifts[(NSUInteger) [indexPath row]];
    [[cell textLabel] setText:lift.name];
    [cell setBackgroundColor:[UIColor whiteColor]];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Workout %@", name];
}


@end