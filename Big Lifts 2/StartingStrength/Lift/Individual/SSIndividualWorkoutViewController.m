#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkout.h"
#import "IIViewDeckController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "Workout.h"
#import "Set.h"
#import "SetLogStore.h"
#import "SSWorkoutStore.h"
#import "SSStateStore.h"
#import "SSState.h"
#import "SSVariant.h"
#import "SSVariantStore.h"

@implementation SSIndividualWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.workoutIndex = 0;
    self.individualWorkoutDataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:self.ssWorkout];
    [self.workoutTable setDataSource:self.individualWorkoutDataSource];
    [self.workoutTable setDelegate:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.individualWorkoutDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell bounds].size.height;
}

- (IBAction)nextButtonTapped:(id)sender {
    self.workoutIndex++;

    [self.individualWorkoutDataSource setWorkoutIndex:self.workoutIndex];
    [self.workoutTable reloadData];

    if (self.workoutIndex == self.ssWorkout.workouts.count - 1) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
        [self navigationItem].rightBarButtonItem = doneButton;
    }
}

- (void)doneButtonTapped:(id)o {
    [self logWorkout];
    [self saveState];
    [[SSWorkoutStore instance] incrementWeights:self.ssWorkout];
    UIViewController *controller = [[self navigationController] viewControllers][0];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [controller.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssTrackViewController"]];
}

- (void)adjustAlternation {
    if ([self.ssWorkout.name isEqualToString:@"A"]) {
        SSState *state = [[SSStateStore instance] first];
        state.workoutAAlternation = [state.workoutAAlternation intValue] == 0 ? @1 : @0;
    }
}

- (void)saveState {
    SSState *state = [[SSStateStore instance] first];
    state.lastWorkout = self.ssWorkout;
    [self adjustAlternation];
}

- (void)logWorkout {
    WorkoutLogStore *store = [WorkoutLogStore instance];
    WorkoutLog *log = [store create];
    log.name = @"Starting Strength";
    log.date = [NSDate date];

    for (Workout *workout in self.ssWorkout.workouts) {
        for (Set *set in [workout workSets]) {
            [log.sets addObject:[[SetLogStore instance] createFromSet:set]];
        }
    }
}

@end